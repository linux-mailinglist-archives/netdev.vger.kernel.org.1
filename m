Return-Path: <netdev+bounces-53625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B4B803F35
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6AD1F211B0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35533CFD;
	Mon,  4 Dec 2023 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qMSElPWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78937CB
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:24:22 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d8e816f77eso11801947b3.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701721461; x=1702326261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfoiTr5fTxRdu5IYw5VlaXEaqDHOxpGp2Ev7i/8Ze5M=;
        b=qMSElPWM37Imgvf9/weoZs+C81AtjaSmK12dFFdMwH4qv51sXjxjj9v5yCQsCQ8llx
         DXfnRxJ+sUvrrR0RnFfMdOtUxCwK0bYfCM2FWR2WUM44TRjPwXpkSI+gSNmDKVpJEbWX
         QhFo/MvhENJrhQ/e56cMjAeP7nojbBbmWo2u4eetBd0szuTQxWnwMNYIftcntoOmdsw4
         1k/ALziaLM/P3OeySWYeurW2nqvoAgNtG10g01TyWhQ5bNVDPKfp6ZehmQO0QGhliD7c
         HnL0R0PKWv02/rBKYUjhMwa2TKpe/3NZ91DC3dtPcaafS33v2orANxqMWH5bPIbuHFqf
         MZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721461; x=1702326261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfoiTr5fTxRdu5IYw5VlaXEaqDHOxpGp2Ev7i/8Ze5M=;
        b=S1EGquFlq3V4oOIpI5qMsRwkM1LrpihVcSoo76tW8UAQr2Pdb25ASRcuQgRgsUwVyt
         Ql08QXP7oEwvYGGw0ILkGkRHkyUnT8KILumQVCJcBu2Wa3GMvOIHvzvgut0MSVrfG0S4
         FpkFp4P9bO7JLiviKXGIConSyd6s6EwInf09oi1+Ruik5riTASwfTYqi1Pw/Sd2e4/QI
         xqP2w5NpFoX4LC9RE73sHPqaQSZC5c1g5LwHSrLU9xiWzEsPCBDbkpq5fmztGgQnEO1S
         NCaqZEy139E5V87LjoVivra099ehNDJ6eqs0a6n3lUKHRaOWo3FQ5KMvaZgS0Qc2+rKA
         UfrA==
X-Gm-Message-State: AOJu0Ywk1JggYC/z4NHPvz3oS02UU5fVixOlulmoLnLWrFdWKA/RA6CM
	q8zy2v23H65thC9QGWJXlphvWo2s9ku8GZzzOx/T4ipCf9WNjxZgIAg=
X-Google-Smtp-Source: AGHT+IENsUBG7Zzu92WUhHi/Q4Lp7l4su/3JlXtlqRPmhddJ0Ov6ZZ1U9oI4mX0+cMwkOiTC7OzV1XaCvBDQ/ntTuAw=
X-Received: by 2002:a05:690c:3581:b0:5d8:a45e:3755 with SMTP id
 fr1-20020a05690c358100b005d8a45e3755mr1880057ywb.11.1701721460784; Mon, 04
 Dec 2023 12:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1674233458.git.dcaratti@redhat.com> <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
In-Reply-To: <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 Dec 2023 15:24:09 -0500
Message-ID: <CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com>
Subject: Mirred broken WAS(Re: [PATCH net-next 2/2] act_mirred: use the
 backlog for nested calls to mirred ingress
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, wizhao@redhat.com, 
	Cong Wang <xiyou.wangcong@gmail.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 12:02=E2=80=AFPM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> William reports kernel soft-lockups on some OVS topologies when TC mirred
> egress->ingress action is hit by local TCP traffic [1].
> The same can also be reproduced with SCTP (thanks Xin for verifying), whe=
n
> client and server reach themselves through mirred egress to ingress, and
> one of the two peers sends a "heartbeat" packet (from within a timer).
>
> Enqueueing to backlog proved to fix this soft lockup; however, as Cong
> noticed [2], we should preserve - when possible - the current mirred
> behavior that counts as "overlimits" any eventual packet drop subsequent =
to
> the mirred forwarding action [3]. A compromise solution might use the
> backlog only when tcf_mirred_act() has a nest level greater than one:
> change tcf_mirred_forward() accordingly.
>
> Also, add a kselftest that can reproduce the lockup and verifies TC mirre=
d
> ability to account for further packet drops after TC mirred egress->ingre=
ss
> (when the nest level is 1).
>

I am afraid this broke things. Here's a simple use case which causes
an infinite loop (that we found while testing blockcasting but
simplified to demonstrate the issue):

----
sudo ip netns add p4node
sudo ip link add p4port0 address 10:00:00:01:AA:BB type veth peer
port0 address 10:00:00:02:AA:BB
sudo ip link set dev port0 netns p4node
sudo ip a add 10.0.0.1/24 dev p4port0
sudo ip neigh add 10.0.0.2 dev p4port0 lladdr 10:00:00:02:aa:bb
sudo ip netns exec p4node ip a add 10.0.0.2/24 dev port0
sudo ip netns exec p4node ip l set dev port0 up
sudo ip l set dev p4port0 up
sudo ip netns exec p4node tc qdisc add dev port0 clsact
sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip
prio 10 matchall action mirred ingress redirect dev port0

ping -I p4port0 10.0.0.2 -c 1
-----

reverting the patch fixes things and it gets caught by the nested
recursion check.

Frankly, I believe we should restore a proper ttl from what was removed her=
e:
https://lore.kernel.org/all/1430765318-13788-1-git-send-email-fw@strlen.de/
The headaches(and time consumed) trying to save the 3-4 bits removing
the ttl field is not worth it imo.

cheers,
jamal

