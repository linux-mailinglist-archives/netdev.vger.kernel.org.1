Return-Path: <netdev+bounces-294126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LoUEBKpHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:57:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F162C01E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D45D302BE93
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0937A3D5673;
	Tue,  2 Jun 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCPMbLBN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338843D3D03
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393632; cv=none; b=XdVqGD2YqqfDeHO+uFIfishJWwGOmJ/mS4VBRG4uM1GgGPst3fD8Z7RYbR9VBVkaBAI0sjFj/7P/fyGbF/A7JF1TE9tyslRESMaCtszOw+86BmlPl93u2Wp1LU/KdFqP/ga15rK15OGTDjVL6SyAU6TL5JRNpzp0DDY4W3POrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393632; c=relaxed/simple;
	bh=GH+I9RsdgTE0OHCyZhbjj1jnDfvIU8wsj/dmNuKaUik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFjwNUcWw4+dyiwZDSwj4HrVKUbErlaGef4+02KIy6Wg/Z853zARd/rlEOmXhCiwtYe6um04+tkJDtfFhy67bWgr2ChyU8nfpfaw2vgt/OSm697L16e5Ka6Ee/ztojea8cPYQ3nRG4K9FqekkwPbOCXkz+yjzaUTP6M45BTFYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCPMbLBN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso22202775e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780393629; x=1780998429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwsVWUXBBycIdE/ihGu428I0auaTKDjLFd3QwYVOS/Y=;
        b=XCPMbLBN/aiL5UzjeAZ5SxMnzjYDorlpHiZ040eFaOnQewYh3S2sj8+R7hJ9FCBQ63
         HDYqUPDb08TXuBeU3Fv8s5awpntIaj4W3iD91nwtSbTtSoobPsdmfq3j1Qi14PId6etH
         BUySj8pjuySeDbu5mDA92ac3baYqpxI420pk2m7RD5gvDN4wzF/tgrpIM61jgFHW3Miu
         CCk5rwFe148YaKtlGSOx136hT9W3QO8WSHpP/vEmfdAbjGkU9bbldNA0hykPg7fafilN
         w4smA3ulkSDCFINcTUTCCHVZLqBA3bh6wuLX2BZVj86E+fQrgiBRh9IbZ3THEaAYhiZ4
         NccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780393629; x=1780998429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwsVWUXBBycIdE/ihGu428I0auaTKDjLFd3QwYVOS/Y=;
        b=jZ+3NeMUwioEXeyAiuBMesNQPcQbUysLpwA6hxzxo52g6IKf9QRd5gx8ndqn8z0VQu
         QLaMZtOWh3GixlDMtyRJL4Ceyn9P9kyLBKgKNZ8Umt1AWA001xvwpZ7sE+8y6iylwWDX
         8In2w6GeXEsogUg6x7B2n9IfNizkvsXmG4NoPiA84Qzc0HeFoi/YcHUXQnFUrs1hq8nO
         8J3V4SwRrZcO6UQy2mcXMrBBYpK6UteMGsgtWFbJlBeV5CrmsXrbS/tS6pAgzCsptwhb
         3sLnGcU5Nw180JJ4zetn4kw7vFwF/Tdi6lTlbu0PYv9/wGntp/X9I3t8aDZDf0A4rD+X
         OtFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QWKQRqFMpdmcIAEBrQI2ObO5R94Iyq7St3/7E1qqGQZ1KsBf+JAZe1AWIlIQtR9Lz2aNaQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXkcOz83E7Bncua7/wIJOzN1lHum12RfoEXtHUf/+lhxZUb3Qn
	ecUDOQlY22dc0fJ6QXj4ZO83MbSwLeWEkDPMZz6uIFATNrUhTRNuHprU
X-Gm-Gg: Acq92OHqxNk0H0Hq0WEOw/uoO0svZtWXSaY9jAGFkTKQsyElwXfNsqVjkdMbQS7zv2k
	uk4wRyRnXRSaX+4ctUC4E1JsHbYOn2DXg+7/rE+E8cOwpyX8fXrUfExr3lygrLuHPmqLeLIsBkX
	kK3QKz17T5ExUjQQ6Y4wPkFw2UjV/OBOIOhh9jdQxIl/UR/fMVOnakRrCTCa4MwshAU4Y78T5wO
	yj/ov4u9wZ54Fsk5iOt5j0SHyuiBREp06IYYWHd9DH0tMt/J6Yv5ewYXv9gF71DA4teIU3nn/eq
	9LZ937uImWR/bNxi+XoxphSTYIZvqLAeJrqxqP8V1wFKmschc9RxCHx3ij27zKj6KCYJHKovdzE
	Fw/SdqTu0OeYvEFTJ35AqxF0FP9VgPxr5q9CvB33stTsfvZY2/IxdaoDuGosH6MtQOPnPvMzv2i
	EMkk4yuluZ1a3OfOc94l42CgPYdFvR1fTN+2EE5oK0dEbOkabAM0+tuE3862BH6Hpq1Yys1ydXh
	RFvKt68Zw==
X-Received: by 2002:a05:600d:8654:10b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490a29121b8mr207121565e9.1.1780393628119;
        Tue, 02 Jun 2026 02:47:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b3cff37fsm2620125e9.16.2026.06.02.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:46:59 -0700 (PDT)
Date: Tue, 2 Jun 2026 10:46:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, davem@davemloft.net,
 dsahern@kernel.org, horms@kernel.org, idosch@nvidia.com,
 jianhao.xu@seu.edu.cn, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, runyu.xiao@seu.edu.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260602104647.51ccadce@pumpkin>
In-Reply-To: <CANn89iJWcG6UH0ZqLnjRaCr0Ky6WeEYhj-pyeyrPf3oJcHU5KQ@mail.gmail.com>
References: <20260601223122.63c0d23f@pumpkin>
	<20260601231546.3407019-1-kuniyu@google.com>
	<20260602090034.7a5c243e@pumpkin>
	<CANn89iJWcG6UH0ZqLnjRaCr0Ky6WeEYhj-pyeyrPf3oJcHU5KQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BF8F162C01E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294126-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2 Jun 2026 01:10:49 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Jun 2, 2026 at 1:00=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Mon,  1 Jun 2026 23:14:44 +0000
> > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > =20
> > > From: David Laight <david.laight.linux@gmail.com>
> > > Date: Mon, 1 Jun 2026 22:31:22 +0100 =20
> > > > On Mon, 1 Jun 2026 05:36:37 -0700
> > > > Eric Dumazet <edumazet@google.com> wrote:
> > > > =20
> > > > > On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> > > > > <david.laight.linux@gmail.com> wrote: =20
> > > > > >
> > > > > > On Sun, 31 May 2026 23:39:46 +0800
> > > > > > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > > > > > =20
> > > > > > > ipv6_flowlabel_get() still reads the shared per-net sysctl fi=
elds
> > > > > > > flowlabel_consistency and flowlabel_state_ranges with plain l=
oads,
> > > > > > > while writers update them through proc_dou8vec_minmax(). Thes=
e checks
> > > > > > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain re=
ads leave
> > > > > > > KCSAN-visible data races and can make the policy checks obser=
ve stale or
> > > > > > > inconsistent values.
> > > > > > >
> > > > > > > The race can be reached on a running system by toggling
> > > > > > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > > > > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task =
repeatedly
> > > > > > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > > > > > state-ranges flow label.
> > > > > > >
> > > > > > > This issue was first flagged by our static analysis tool whil=
e scanning
> > > > > > > lockless IPv6 sysctl readers, then manually audited on Linux =
v6.18.21.
> > > > > > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEM=
U/KCSAN by
> > > > > > > concurrently flipping the two sysctls while TCP reflect and U=
DP
> > > > > > > state-ranges setsockopt actors exercised ipv6_flowlabel_get()=
. KCSAN
> > > > > > > reported races between proc_dou8vec_minmax() and the two plai=
n-load
> > > > > > > sites in ipv6_flowlabel_get().
> > > > > > >
> > > > > > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side =
reproducer
> > > > > > > also hit the inline ip6_make_flowlabel() reader through
> > > > > > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is al=
ready
> > > > > > > fixed in this tree by commit ded139b59b5d
> > > > > > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The =
remaining
> > > > > > > plain readers in this tree are both in ipv6_flowlabel_get().
> > > > > > >
> > > > > > > Use READ_ONCE() for those remaining sysctl reads so they foll=
ow the same
> > > > > > > lockless reader contract already used by other IPv6 sysctl re=
aders.
> > > > > > >
> > > > > > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > > > > > >
> > > > > > > Representative QEMU/KCSAN reports from the two target reader =
paths:
> > > > > > >
> > > > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_=
minmax
> > > > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > > > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > > > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > > > >          tcp_setsockopt+0x72/0xb0
> > > > > > >
> > > > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_=
minmax
> > > > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > > > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > > > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > > > >          udpv6_setsockopt+0x21/0x40
> > > > > > >
> > > > > > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > > > > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > > > > > ---
> > > > > > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >A
> > > > > > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabe=
l.c
> > > > > > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > > > > > --- a/net/ipv6/ip6_flowlabel.c
> > > > > > > +++ b/net/ipv6/ip6_flowlabel.c
> > > > > > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock=
 *sk, struct in6_flowlabel_req *freq,
> > > > > > >       int err;
> > > > > > >
> > > > > > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > > > > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > > > > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consis=
tency)) { =20
> > > > > >
> > > > > > That can't actually fix anything. =20
> > > > >
> > > > > It fixes a KCSAN splat.
> > > > >
> > > > > If you think you can fix KCSAN instead, please do so. =20
> >
> > ipv6.h has:
> >         u8 flowlabel_consistency;
> >
> > KCSAN probably shouldn't care about byte reads. =20
>=20
> KCSAN detects more than just load/store tearing. Here is a summary:
>=20
> Purpose: KCSAN identifies data races, which are a common source of
> correctness, stability,
> and security bugs in concurrent systems like the Linux kernel.

Ok, it can pick up CSE type issues as well.
But this one is still a false positive.

-- David

>=20
> Mechanism: It is a compiler-instrumentation-based tool. During
> compilation, special code is added to monitor memory accesses.
> At runtime, KCSAN detects when multiple threads access the same memory
> location without proper synchronization,
> and at least one of those accesses is a write.
>=20
> Operation: KCSAN performs its analysis at runtime, reporting data
> races that actually occur or nearly occur during code execution.
> While powerful and scalable across the entire kernel, this
> instrumentation can significantly slow down kernel execution.
>=20
> Impact: KCSAN has been instrumental in finding and fixing numerous
> concurrency bugs.
> For example, it has led to the addition of annotations like
> READ_ONCE() and WRITE_ONCE()
> in kernel code (e.g., in the TCP/IPv6 stack) to properly handle
> lockless reads and writes and resolve reported data races.
>=20
>=20
>=20
>=20
> > =20
> > > >
> > > > It is a false positive. =20
> > >
> > > It's not.
> > >
> > > =20
> > > > (Which I think you also said in a different email. =20
> > >
> > > I guess you meant this one ?
> > > https://lore.kernel.org/netdev/20260601074201.1186061-1-runyu.xiao@se=
u.edu.cn/
> > >
> > > This is different because, in addition to Eric's comment, IPv6
> > > address is 128-bit and data-race is inevitable without locking
> > > unless CPU supports native 128-bit read/write; we already do
> > > load/store-tearing of 128bit with u32/u64. =20
> >
> > But the code isn't looking at a 128bit value, it is only doing a check
> > for zero (and READ_ONCE() doesn't support 128bit values).
> > If there is no locking the value can change just before/after the test.
> > Even if it were subject to read/write tearing absolutely the worst that
> > could happen is a zero being detected when the value changes between
> > two non-zero values.
> > That isn't relevant here - it is just a boolean. =20
>=20
> It is completely relevant. If you disagree, please fix KCSAN.


