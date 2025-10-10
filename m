Return-Path: <netdev+bounces-228536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BDBCD83B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356314FFD3D
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36C2F2617;
	Fri, 10 Oct 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3R7iTV0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7E16A956
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106266; cv=none; b=bqNY//MpCKJHLIDCXP4CEw6oEk1mm+b2lgYqJBXh/DHEqjljwWN0besP/HJxDZLBLy9zl4SeOVZq7SmCSlli2q67dJ+aga+KrJeB7Ao0kf2WLzpPG7qDkWxMV1tUTYK5H72hwaSupe48MX/ngmhzYBKCc7kmWdN6lGGkbucpQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106266; c=relaxed/simple;
	bh=N2dTPoCvjnG5O6bi0PY/aAHhiM/SFLrLWkOPBF3oB6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxTuZ1yB0B2tuVPc8Nd7ZPs0xMdvHW9Y+qTvTOGg5chgyxIKLAKUzCDu3qVmew2xjnPxfvgNxMYzxUd6joI2pEd2UhRCQrC3Q0VWgrbcO6ZlR4ORvQmogAKEF1n6gF2jKJXq7bO0fUOSmksYR5m7R7Td2XFxWyeLX2n4TcsvKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3R7iTV0; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-635fde9cd06so2296926d50.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760106264; x=1760711064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4faKLk8C1/XdbUxpctbOtmJIR1+qz/ornIASd96/VRk=;
        b=E3R7iTV00ejCTCOmBnhuJiEcfUh+aBX6/0u4v38JSYlINriEdf3ZvZfroQd/tJ2jTs
         Q+1nClQI9qHDKtaACUxLz4IkBC5kUrh965VeK3DdEBKMW5aU4xmpgzzKSSyYk+Nc2Ltj
         G4SHXMKtODxWRc9EdhZH0JmY4YTI1OHOeUeWmFzqfNrGPw/chvGXncmmFHaAHzCR8/BN
         sXJA32iEvDgq6tc8BDQpSZwKGiCijXnQz8Grl7soE0lfEKQCF/NGIKdMG5I3qJeQMmTI
         Dl4gRSNb97dYut0N82PndCKE9WuSaNgeOvdxG70jmKflLn9cmpjyrUzjppaxMmyOEHPB
         Kqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106264; x=1760711064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4faKLk8C1/XdbUxpctbOtmJIR1+qz/ornIASd96/VRk=;
        b=XerCTKMH/YK26wKXYICuGjNQiWkwCvmRe2pyKW+6YO6Br/9fxrDrYERW/y5ZSdHqRR
         tn+t/c3Y3Nd1mLgoLazYqMCSLsoMTOcGQVC7o/T61P4Ch36oMupMZjeCsYkqm0GT3hti
         wwJrKR3leAAAibNodj7pFBXDD3fcBtwifjzgYPoPiOTl3uy9PBBdf8y1LQC26dlyKbOq
         4qPnSaw/GU5XRecRvM36ZZ/6q6VzpRHhURpzNwwcKiC83UTP1tXC7C2vZvYH0XWr64mF
         7VENZ0rrYo0UgYlv2PYCgjJ4dO2Id8Q9EoI+k/el3qJFMS5sFJYorm8G9nuXB39ol1La
         TcpA==
X-Forwarded-Encrypted: i=1; AJvYcCX3WuveyHgIjxkQwpqqaOwa3iW0jvgYMAXYWFQC1Dkh59YFXLRh+NDcXQjYKi70FzJ/UNG/Qjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSD+uV1k+E7If/JmzTu+9yJBevSWAROz3780yY3Ne26nlkXd9
	g3dwwIwqcTlyz3FYvrqGYQh4VWeMuFhJld0LMcNExvtXbDS+eknIbp2YU5/HA/ot00VAGaOz3WI
	ednwZFugn+GnYHLzhCPGkOgYy64icN3SR8IeZp/Ba
X-Gm-Gg: ASbGncuV0jULxPWXbGmXM+elzhTXcizitGmouQoqX/4TQTdYkvQZTuIMwW8ehc0915U
	KVB+D+wKwWDCPNvzIFDgwEMHY4ZCDopBcyMzSoAh3nlYA6VoTP5/Xg3TzQ4IKdUxLnL5QjOs3w2
	FHm1ZeDEhCAQW/6zhbkTD2+ro7s8ys/IgqbkEg62iwne427bFMWuHI8QSsTu/p8jA6pISNly5/D
	1YrNSPEGRUMIOumtLU7zqvh5mSFcBENMpGr6ZtVvpWa
X-Google-Smtp-Source: AGHT+IHoz0x073JVyd7nbMq9vAUecxwpYi6Yy56AMQ6653DmvbfmKBzj/Yl3HgfoUbiHIWTsm5vhFwJrS8CykVBixZQ=
X-Received: by 2002:a05:690e:1557:20b0:63c:efd6:c607 with SMTP id
 956f58d0204a3-63cefd6ca19mr1276422d50.3.1760106263842; Fri, 10 Oct 2025
 07:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com> <20251007001120.2661442-4-kuniyu@google.com>
 <25xfv3p3nwr3isf46jcqhgawkgnbks7u4qofk3g43m6pctriss@35fwcsurb2i6>
In-Reply-To: <25xfv3p3nwr3isf46jcqhgawkgnbks7u4qofk3g43m6pctriss@35fwcsurb2i6>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 07:24:12 -0700
X-Gm-Features: AS18NWASNC4TOFRGEHKHhMOswPkVJJrtryw1GaDpU15urT38z14BVR0tl6DDgfY
Message-ID: <CANn89iJyOcBB8_0mRCP30pnX5aD-W2Zu7c=XeYS-JdOEKzBfWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net 3/6] net: Introduce net.core.bypass_prot_mem sysctl.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 4:13=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Tue, Oct 07, 2025 at 12:07:28AM +0000, Kuniyuki Iwashima wrote:
> > If a socket has sk->sk_bypass_prot_mem flagged, the socket opts out
> > of the global protocol memory accounting.
> >
> > Let's control the flag by a new sysctl knob.
> >
> > The flag is written once during socket(2) and is inherited to child
> > sockets.
> >
> > Tested with a script that creates local socket pairs and send()s a
> > bunch of data without recv()ing.
> >
> > Setup:
> >
> >   # mkdir /sys/fs/cgroup/test
> >   # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
> >   # sysctl -q net.ipv4.tcp_mem=3D"1000 1000 1000"
> >   # ulimit -n 524288
> >
> > Without net.core.bypass_prot_mem, charged to tcp_mem & memcg
> >
> >   # python3 pressure.py &
> >   # cat /sys/fs/cgroup/test/memory.stat | grep sock
> >   sock 22642688 <-------------------------------------- charged to memc=
g
> >   # cat /proc/net/sockstat| grep TCP
> >   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 5376 <-- charged to tcp_=
mem
> >   # ss -tn | head -n 5
> >   State Recv-Q Send-Q Local Address:Port  Peer Address:Port
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53188
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:49972
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53868
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53554
> >   # nstat | grep Pressure || echo no pressure
> >   TcpExtTCPMemoryPressures        1                  0.0
> >
> > With net.core.bypass_prot_mem=3D1, charged to memcg only:
> >
> >   # sysctl -q net.core.bypass_prot_mem=3D1
> >   # python3 pressure.py &
> >   # cat /sys/fs/cgroup/test/memory.stat | grep sock
> >   sock 2757468160 <------------------------------------ charged to memc=
g
> >   # cat /proc/net/sockstat | grep TCP
> >   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 0 <- NOT charged to tcp_=
mem
> >   # ss -tn | head -n 5
> >   State Recv-Q Send-Q  Local Address:Port  Peer Address:Port
> >   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:49026
> >   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:45630
> >   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:44870
> >   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:45274
> >   # nstat | grep Pressure || echo no pressure
> >   no pressure
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

