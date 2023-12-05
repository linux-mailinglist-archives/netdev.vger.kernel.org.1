Return-Path: <netdev+bounces-53885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E4805150
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48C11C20BB0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBD3E48A;
	Tue,  5 Dec 2023 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy6URnmD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B8199D
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701773673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVej9PrmR86I2amOEZJmuPA8qC8UiKK/HyCsbg/KCWM=;
	b=Cy6URnmDSLkCwKDpOmQLl1ksaiV+ryHtluH50QjonXGlcmR68mW/KOkAElxXrvDRe9eVpR
	qH/B6qPTcQK+K2ckUWvVIw++GHtVZs61fLdqKKAtxuECxWxkjrjtlymK21KxSjAm+tFtQv
	ojR3nCm6Z+IEPj7B0gypi20t7wKeBc4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-gF6kFNllNRmtB0SIIbkgOA-1; Tue, 05 Dec 2023 05:54:32 -0500
X-MC-Unique: gF6kFNllNRmtB0SIIbkgOA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c9ec1a2ec1so28044921fa.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 02:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773669; x=1702378469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVej9PrmR86I2amOEZJmuPA8qC8UiKK/HyCsbg/KCWM=;
        b=rz9DJWN2A/Td2znIDoqMS0bXbZnRYPS+ydQycHCByb+2m82y/Fcq1tryZ+s4mObQzW
         xhMVZFSv2pdTmEcghTA+zM52CsDs21xcyzcNGaAO7J+XNWP+L+BxkpWAsuuuCm9OwVO5
         yLsh9hV9IIlOHaMowGggFbE+XQt8N2xpMoRTAB3UfHupCgxhR6J3JJKDlqp0LGtUDKdQ
         +KgjXoWZqgqv0gRAHSi8UY4h20mNDAeEZ1gW+fTCrJnRoE2RjwMnzmYGIYzOrKMidkAL
         SbNw0Yltur/Je2PtfaGTxvXT9bQs7CTYnwj9kudeGDoOwZorfnKsj8F3IeuyjhaVz4Hu
         2U5A==
X-Gm-Message-State: AOJu0Yztx+iYtlLr7KJZEW/vmOF8MQ4vWT33uLu0fy7d7kYh2vKR0Xdw
	GqdMHEp6a5PeLs0JgNnoOxuvHjgIoxhMbEiJ3icMqqYWnjzFbqyCO3fzkkcFCJt6wv8BHFx4wJ3
	d38Y0r7nOyFw+bh15UO2AWIee0Aur3jEuSzpYak6w07g=
X-Received: by 2002:a2e:2404:0:b0:2ca:3b0:c981 with SMTP id k4-20020a2e2404000000b002ca03b0c981mr1288361ljk.60.1701773669513;
        Tue, 05 Dec 2023 02:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2ssRiYVRsSgeOHK8e4z0hKb3eKncd2x9tZR3khs5rrow+lEW/yyuTe12zSKhzeqVFdesF3BIBVj0FrDDsCCs=
X-Received: by 2002:a2e:2404:0:b0:2ca:3b0:c981 with SMTP id
 k4-20020a2e2404000000b002ca03b0c981mr1288359ljk.60.1701773669206; Tue, 05 Dec
 2023 02:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1674233458.git.dcaratti@redhat.com> <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
 <CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com>
In-Reply-To: <CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 5 Dec 2023 11:54:17 +0100
Message-ID: <CAKa-r6sNMq5b=PiUhm0U=COV1fE=HL_CjOPxchs1WpWi4-_XNA@mail.gmail.com>
Subject: Re: Mirred broken WAS(Re: [PATCH net-next 2/2] act_mirred: use the
 backlog for nested calls to mirred ingress
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, wizhao@redhat.com, 
	Cong Wang <xiyou.wangcong@gmail.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Jamal, thanks for looking at this!

On Mon, Dec 4, 2023 at 9:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Fri, Jan 20, 2023 at 12:02=E2=80=AFPM Davide Caratti <dcaratti@redhat.=
com> wrote:
> >
> > William reports kernel soft-lockups on some OVS topologies when TC mirr=
ed
> > egress->ingress action is hit by local TCP traffic [1].
> > The same can also be reproduced with SCTP (thanks Xin for verifying), w=
hen
> > client and server reach themselves through mirred egress to ingress, an=
d
> > one of the two peers sends a "heartbeat" packet (from within a timer).

[...]

> I am afraid this broke things. Here's a simple use case which causes
> an infinite loop (that we found while testing blockcasting but
> simplified to demonstrate the issue):

[...]

> sudo ip netns exec p4node tc qdisc add dev port0 clsact
> sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip
> prio 10 matchall action mirred ingress redirect dev port0

the above rule is taking packets from port0 ingress and putting it
again in the mirred ingress of the same device, hence the loop.
I don't see it much different than what we can obtain with bridges:

# ip link add name one type veth peer name two
# ip link add name three type veth peer name four
# for n in even odd; do ip link add name $n type bridge; done
# for n in one two three four even odd; do ip link set dev $n up; done
# for n in one three; do ip link set dev $n master odd; done
# for n in two four; do ip link set dev $n master even; done

there is a practical difference: with bridges we have protocols (like
STP) that can detect and act-upon loops - while TC mirred needs some
facility on top (not 100% sure, but the same might also apply to
similar tools, such as users of bpf_redirect() helper)

> reverting the patch fixes things and it gets caught by the nested
> recursion check.

the price of that revert is: we'll see those soft-lockups again with
L4 protocols when peers communicate through mirred egress -> ingress.
And even if it would fix mirred egress->ingress loops, we would still
suffer from soft-lockups (on the qdisc root lock) when the same rule
is done with mirred egress (see an example at
https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomment-178=
2690200)
[1]

> Frankly, I believe we should restore a proper ttl from what was removed h=
ere:
> https://lore.kernel.org/all/1430765318-13788-1-git-send-email-fw@strlen.d=
e/
> The headaches(and time consumed) trying to save the 3-4 bits removing
> the ttl field is not worth it imo.

TTL would protect us against loops when they are on the same node:
what do you think about inserting a rule that detects BPDU before the
mirred ingress rule?

thanks!
--=20
davide

[1] by the way: the POC patch at
https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomment-178=
2654075
silcences lockdep false warnings, and it preserves the splat when the
real deadlock happens with TC marred egress. If you agree I will send
it soon to this ML for review.


