Return-Path: <netdev+bounces-106508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07788916A04
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B469D2830CB
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418116C840;
	Tue, 25 Jun 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBDgz0Ir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0039FD6
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324980; cv=none; b=EdiIFN/TolQF4r0eEG1C5EmXrE2xBWn+orpuvoj330C25XUIE8S4dyWPz7m0YHgc7Dou6e/jVEXzx9+VQN3JZquSq20hMJn/dDosjfcR3TvzA171zP0CGWL7n3XiYruLhdfbcZzh2yJW6xenXD5RSeucVz8QOPxNHdy9ntmtxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324980; c=relaxed/simple;
	bh=v5/BN7Hm8eXOX6GvRiGj1yPcrrgAcTj4SdgdQ8HMC7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iip3ducaz0lnRoEyLKzi6YyeGy0UxoK/rVVD+m06qXDXBm1u6O39e+hlPXZ2kZJ+1DvdS7Qq3udsOzoNqFCyRJSmDiAWlfYrcvBZDCEHry484WO3owSHpOM6W4yfSlHgUJkciDi94USHM2bqGtgrL0mxI8vol52Ny95qxU8ldgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBDgz0Ir; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so6149369a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719324976; x=1719929776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txMg1yBI3C5zZj9b3iG0sb1mrfRfqVzlgNpFi+lwATA=;
        b=cBDgz0IrhdcnC5u6hsKi2f2IN5dG2AwSD8TmyZDMAREquSUz+kriac2F6yiZ568ao6
         G1RPef5TOaushP9LQddVaVmc2e51YWdpgTPYaepx5xgt11/yLRwtQ+nA8LeAJvvhNeOQ
         qcCjZid3nVf1/6jBj8KbcZJ+4JdLMjIedK3FOx8OnuBuLoZsdIF23HNrotNzf7427nwe
         IeqkgaZF8WjM1Ze0DMoo1SMvfXjKIoCS/0mrA4EcUtW4GVx6vornhhrkfbE8sfic6hnV
         jxDi1IkPm7UIhldLjcUJKUrEz77aSOjVn+zJ/T3G9SAMH3THXPYlh/mTCNbjuKU49h0S
         cB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719324976; x=1719929776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txMg1yBI3C5zZj9b3iG0sb1mrfRfqVzlgNpFi+lwATA=;
        b=w6m/3KwXWLjuaVnrdeZiZgcYp6cVo6z59aN1yHMJNTX+LXZtYs98CfrUi8Sz2A1sPE
         MzhE3KuzCc+c5r4XepM3bSozp6ToBRds6zSPiPCWjkl0lJcMkX8Ffhd0Xqv7t+hCwPD3
         4Ghtos+s6Q2YcQ/Njgl8e+XjuQ14hDShhuzj2llHmO+/y3M7TjLPlLJKw1xp8M6e7ssh
         QnMrKGZExKY6EAsAJRfQ5hTezu8QPJYqAo+/a5wp25TdfRca+lT8LJ5fKHhjaf+s524o
         zfudqgwNmL3l2/F64fFx8vSyTwqPQY+TMa+YWVT6Gv8dPzTR4EpXIRFi++VJiuT7rvaM
         eLtg==
X-Gm-Message-State: AOJu0YzrrFirLdKaOZkCKfcsHGBnQtOiacsXbwg6wAb9YpzHg1UjIdYw
	8N0Boe2e5ssc/gxLrbhRMlDzYEEcShaitELEHJrFpH42Ijs6+jgUdPKcciDtnRPIzvmQwnsgIGU
	k80qeWNSROOWmBGE+qZ7tr1+aP3ienPFvYl+MaP9br1Q97mTddm74tRY=
X-Google-Smtp-Source: AGHT+IFscpUDigK3sjiafRtyPgDq4I1SxTB/v4k5zCynhP82Entzul2Gkuvq6bg+VXWqgIpi6/XH2Nq4EJopbPxoaxU=
X-Received: by 2002:a17:907:c301:b0:a6f:5f5d:e924 with SMTP id
 a640c23a62f3a-a7245b4c9bcmr662856066b.6.1719324975303; Tue, 25 Jun 2024
 07:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625024721.2140656-1-almasrymina@google.com>
In-Reply-To: <20240625024721.2140656-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 25 Jun 2024 07:16:00 -0700
Message-ID: <CAHS8izO1g5vZodyvKBNyE-Fx7A4EoD70RuDLwXtzE3yvfRw_2g@mail.gmail.com>
Subject: Re: [PATCH net-next v13 00/13] Device Memory TCP
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:47=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> v13: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D861406=
&archive=3Dboth&state=3D*
> =3D=3D=3D=3D
>
> Major changes:
> --------------
>
> This iteration addresses Pavel's review comments, applies his
> reviewed-by's, and seeks to fix the patchwork build error (sorry!).
>

This series is showing a inapplicable to net-next error on patchwork:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D865135

What happened here is that I sync'd to net-next, ran all the tests
including the allmodconfig build which took a few hours, then posted
the series. In the meantime 34 patches got merged to net-next, and one
of those patches seems to generate a git am failure when I try to use
b4 to apply:

b4 am 20240625024721.2140656-2-almasrymina@google.com
...
git am ./v13_20240625_almasrymina_device_memory_tcp.mbx
...
Applying: tcp: RX path for devmem TCP
Using index info to reconstruct a base tree...
M       include/net/sock.h
M       net/ipv4/tcp_ipv4.c
Falling back to patching base and 3-way merge...
Auto-merging net/ipv4/tcp_ipv4.c
Auto-merging include/net/sock.h

Not sure if I'm getting very unlucky or if this was something I can do
to avoid this. I think I didn't tax NIPA too much since it's an apply
error. I'll repost after the 24hr cooldown, sorry again.

