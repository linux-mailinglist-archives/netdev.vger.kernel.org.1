Return-Path: <netdev+bounces-293918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHIhM2MTHmrugwkAu9opvQ
	(envelope-from <netdev+bounces-293918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C52562647E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81CD730A933F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 23:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74538F226;
	Mon,  1 Jun 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cgzx5hQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893B2E0901
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355750; cv=none; b=glee9sZaEQ2ANupUEdSG0aCRe8L96U9ES+2fj2wRyoPav9aVNvzweuwZZHTwCcWfLp8KHAcvuweQ6TBhPUTXWEJYMnTQa6bpI13Vyv+jrnKKPtmZqkTWMSgf42S3+xnFAG03yqtixaWBsXmHXMQNvv3VPfHlOsW23S57LQBdzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355750; c=relaxed/simple;
	bh=lqhOs9ZM01+8ZAhlMBS+uwgzvfPH+kIaLFt0q7E0uME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KVYS7Lg9bNCE+7fMcXLvcptcegnfwxLoQ4/t0EYLcIyDA42U0wDT5ZMd8Iep8uji+J1Qu9uk2MBVOkc5ZVI0MEjFEAKCXa5sKwAF6YHOLuIyCxnfY/1Qib0hgoNXwRXMfFVajRag4RwMw7sGggfK0LPDRiEPJnW0aw+UAOTn78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cgzx5hQa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c1e08848so25372755ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780355747; x=1780960547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MPs5VOvWTvAVcAJdSu8P1ANlCnfNEQ27RwpDFiLF0Y=;
        b=Cgzx5hQayxlGdrScZi/j2eZ7jn/gAAOHq5vKECAPzHtrpjiTL5FeJFnYF4rr06RSZ1
         NmQo4eE+EZdvvKc/px2XuKwoeAhyjl5LcDoeq5b8pi63lHhKFi/j2dQXqiHqcmcWkvU+
         MXP66GUOnsb3g5/teKwKbYQ5Lk5iJjujly0iajz1yJpbkNNzFSZsPxrpqr+RfH1F3C5H
         eK5BsFis/BZj8LRk8Z9tioPq6lrY5wmug6+Ji8CFQmNUxlbAPuMOyyh9uGSECU5SJd0N
         ZDtzBg9+5NBrjUP6NIylPstsoh7B2s49UTZ6yYnLWTpw3jKoXVZbaKz4OGVGFUYvVxgs
         W+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355747; x=1780960547;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+MPs5VOvWTvAVcAJdSu8P1ANlCnfNEQ27RwpDFiLF0Y=;
        b=S7SzqSyvlI02UvxTBYvI0+2XRgUOW6nde2F+S5KFcNkF1qYPFqHidMAkcnXCeCNhI3
         P8JNQjhGVzy8CqrqmTsG+5dk3wHRDGpe7yycQGeKonuk+3oNxr1e79mcFJA+KzkWUe2c
         dGR/Gu3VXTe9WutlHIeqNxI3t0YUT8O7R7dQINzjGaA3sqLXUk9tZbhpqGIVsBcXHKH8
         nqybBoV0EJUN++05LZoAb0QFKtEHkmWwr8VBKGUWwcHzb3ttr3F9loAWDMAxBTNrWeaZ
         T9vMZZPe9qv1akVO2v6fpjnPtnjdlOx8grqQ9Gh1IuNSEeGEZfxO/UTNU+5l9a/k5z3B
         UI/A==
X-Forwarded-Encrypted: i=1; AFNElJ9pcETWzF/Jlax5+aEVYjkqNMtp0Il4YV/J9xx7qA54ibzluaFl/vikH80GVnwaIUNhkOY22pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8elqEWBHznZY+TdIQ2BSEcHhbot3Dn6P1oSiA1aJW0q3Zr1Z
	ZM/Z0ACjrlB9IN+PmeKgUHEUHg07Gi3D1+qsaPdooytrO2mJxsobZneIxJ/7M5ifKtpiPC+fngi
	zK73PYg==
X-Received: from plgw12.prod.google.com ([2002:a17:902:e88c:b0:2bf:33cb:e3a4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:390f:b0:2bd:8395:fedd
 with SMTP id d9443c01a7336-2bf36875f57mr151102895ad.37.1780355746881; Mon, 01
 Jun 2026 16:15:46 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:14:44 +0000
In-Reply-To: <20260601223122.63c0d23f@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601223122.63c0d23f@pumpkin>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601231546.3407019-1-kuniyu@google.com>
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: david.laight.linux@gmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, jianhao.xu@seu.edu.cn, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	runyu.xiao@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C52562647E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Laight <david.laight.linux@gmail.com>
Date: Mon, 1 Jun 2026 22:31:22 +0100
> On Mon, 1 Jun 2026 05:36:37 -0700
> Eric Dumazet <edumazet@google.com> wrote:
>=20
> > On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Sun, 31 May 2026 23:39:46 +0800
> > > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > > =20
> > > > ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> > > > flowlabel_consistency and flowlabel_state_ranges with plain loads,
> > > > while writers update them through proc_dou8vec_minmax(). These chec=
ks
> > > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads le=
ave
> > > > KCSAN-visible data races and can make the policy checks observe sta=
le or
> > > > inconsistent values.
> > > >
> > > > The race can be reached on a running system by toggling
> > > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task repeat=
edly
> > > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > > state-ranges flow label.
> > > >
> > > > This issue was first flagged by our static analysis tool while scan=
ning
> > > > lockless IPv6 sysctl readers, then manually audited on Linux v6.18.=
21.
> > > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSA=
N by
> > > > concurrently flipping the two sysctls while TCP reflect and UDP
> > > > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSA=
N
> > > > reported races between proc_dou8vec_minmax() and the two plain-load
> > > > sites in ipv6_flowlabel_get().
> > > >
> > > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reprod=
ucer
> > > > also hit the inline ip6_make_flowlabel() reader through
> > > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> > > > fixed in this tree by commit ded139b59b5d
> > > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The remain=
ing
> > > > plain readers in this tree are both in ipv6_flowlabel_get().
> > > >
> > > > Use READ_ONCE() for those remaining sysctl reads so they follow the=
 same
> > > > lockless reader contract already used by other IPv6 sysctl readers.
> > > >
> > > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > > >
> > > > Representative QEMU/KCSAN reports from the two target reader paths:
> > > >
> > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > > >          do_ipv6_setsockopt+0x873/0x2220
> > > >          tcp_setsockopt+0x72/0xb0
> > > >
> > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > > >          do_ipv6_setsockopt+0x873/0x2220
> > > >          udpv6_setsockopt+0x21/0x40
> > > >
> > > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > > ---
> > > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >A
> > > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > > --- a/net/ipv6/ip6_flowlabel.c
> > > > +++ b/net/ipv6/ip6_flowlabel.c
> > > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, =
struct in6_flowlabel_req *freq,
> > > >       int err;
> > > >
> > > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)=
) { =20
> > >
> > > That can't actually fix anything. =20
> >=20
> > It fixes a KCSAN splat.
> >=20
> > If you think you can fix KCSAN instead, please do so.
>=20
> It is a false positive.

It's not.


> (Which I think you also said in a different email.

I guess you meant this one ?
https://lore.kernel.org/netdev/20260601074201.1186061-1-runyu.xiao@seu.edu.=
cn/

This is different because, in addition to Eric's comment, IPv6
address is 128-bit and data-race is inevitable without locking
unless CPU supports native 128-bit read/write; we already do
load/store-tearing of 128bit with u32/u64.

