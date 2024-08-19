Return-Path: <netdev+bounces-119893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1C9575D4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D681C21D04
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8015A865;
	Mon, 19 Aug 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQt9NvXr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15815A4AF
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099930; cv=none; b=nPZDSH/pg2TPJ6Ps83iA226zNZJEaYCWxdvKKiMS3qb8Bvi5e1aWhlgsdnKO/4Z0Lotq/2O6IQ1EzC4f+MfArQ3/cuWGi7B0CUSW7pMuEiSV67ntBKMO+8onkwew9DG4OB3pnBehU3+qVNdo1Lg1cP1UrPtTPrvlnI7Qrsav+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099930; c=relaxed/simple;
	bh=5hCWg1nbsBli0YGHvlLtJZAoYo565YPePTccPZa0G94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LveEVsCzgGQ5v7U+h1PB1QzVY6f6hhu8Ytsy7c4302AoWXJxPpP90oO8giZHv0a5TfmTrjwzGXmPAspK7X6CTwS5wHfTtzBLwehibnzn0yVqZ/F9NDkxdlJViuD/dvhA+0gqXoXsDu68GGun5Tht4BLIzNuZ7u4Gp7BbYsgV72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQt9NvXr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d066a5daso321753985a.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724099926; x=1724704726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfUQmRn/EFhMiTzRoHA7ZDzm1OmxjBuZj9W18S8T8rE=;
        b=dQt9NvXrN1VKYzQEcAZvli+TpnUjgqP6GUFJu04Q8N5MsPSHDtblHkM88vHPNmSbf4
         LYLqj/n5ogic1iqNa4Ll9lehU3Gk8/gvI+DrOgO90HkhmVTYUWp/HUadFOdh+q4PHRwS
         uYznAFDmM0qQ16DcdaKNuIrvq5Eqp2ZfyEex5VzrUeVbQNMg4TGvFaZakwXH1qUBTDLq
         dZv0/TDlNmsYrqccyMM25RCA4VdQz5ou3WazXwTrJ7pLK39nxxmCDJXLUwLDCYidmqHI
         U19a6NDUC14Ry56OQV3MwhjC8XFkXSfP6MSqU69zJ9C0q6zOzjsvFoWzeWYLZ6ATRnPR
         ekDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099926; x=1724704726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfUQmRn/EFhMiTzRoHA7ZDzm1OmxjBuZj9W18S8T8rE=;
        b=uMolEXM6oFIcMu5is/CnjNMTChYWh0mlTX+XIUxIQ89fHH7rBTYU2orXMcdGZuDuAJ
         Qx8idliMiEqIMBbzlhI6Y82BFpQ4NA1uJxfye8f1fnMrjmO/Etd7yUfOk/xRb3ZfjUo3
         LD+yNnZYT14Qcjbk88qeqox+Duu74W+xa+lWub99CmvmDiUQkEzxh3icEW4FfuKKJZkv
         D+APmNdqmf69eEt1YLny5u5aYRGnEofHPO537HC0EVPJD00YjrZI4NRGdsVzOp13CfYn
         04IOsQSn9ZC20QJetBdKzfxUZ5Y326J0T5PTY85DyO0E19rONhvnkOVqEp+i3hZMibPc
         z0Ag==
X-Gm-Message-State: AOJu0Yyk/ZxSFBlaGcHmLM+aIZjzaQtBWCt0TSL25Q8nkIQhTFjpU9FT
	/kBtCNamPWgAeF1k3CG8waZ5A6BQcJQe55KqrroeGWRxCz7ZBVB9jgEUip1l757j9MnxflJ7MRN
	87O/d8RfHKnOuRQGTwAuZyQoy+5rYf96ffZhuisR32jHS9OuKokpz
X-Google-Smtp-Source: AGHT+IH9NK+VEbJYkN3LP0eycR7QieY0LFTeKOUKys5z+kSU7zJQmMHAEMe3u1Xxmij2PKgwfzIhek+Uv3hwzgQnvEA=
X-Received: by 2002:a05:6214:53c5:b0:6b7:ab98:b8b4 with SMTP id
 6a1803df08f44-6bf7ce6839cmr162319456d6.48.1724099926079; Mon, 19 Aug 2024
 13:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819035448.2473195-1-almasrymina@google.com>
In-Reply-To: <20240819035448.2473195-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Aug 2024 16:38:32 -0400
Message-ID: <CAHS8izMqcLnmo9792FPkkXPQSBWSjFGO+QHhkou=PaDHLwtsRw@mail.gmail.com>
Subject: Re: [PATCH net-next v20 00/13] Device Memory TCP
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 11:54=E2=80=AFPM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> v20: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D879373=
&state=3D*
> =3D=3D=3D=3D
>
> v20 aims to resolve a couple of bug reports against v19, and addresses
> some review comments around the page_pool_check_memory_provider
> mechanism.
>
> Major changes:
> - Test edge cases such as header split disabled in selftest.
> - Change `offset =3D 0` back to `offset =3D offset - start` to resolve is=
sue
>   found in RX path by Taehee (thanks!)
> - Address a few comments around page_pool_check_memory_provider() from
>   Pavel & Jakub.
> - Removed some unnecessary includes across various patches in the
>   series.
> - Removed unnecessary EXPORT_SYMBOL(page_pool_mem_providers) (Jakub).
> - Fix regression caused by incorrect dev_get_max_mp_channel check, along
>   with rename (Jakub).
>

Looks like in this iteration I resolved the previous test failure, but
introduced a build regression with certain configs:

ld: vmlinux.o: in function `netdev_rx_queue_restart':
(.text+0x6a4133): undefined reference to `page_pool_check_memory_provider'
make[3]: *** [../scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[2]: *** [/home/kunit/testing/Makefile:1156: vmlinux] Error 2
make[1]: *** [/home/kunit/testing/Makefile:224: __sub-make] Error 2
make: *** [Makefile:224: __sub-make] Error 2

Looks like I'm not build testing with enough config variations (in
this case CONFIG_NET=3Dy but CONFIG_PAGE_POOL=3Dn). I've fixed the issue
locally and added a test to my presubmit checks with this config and a
couple of risky others. Sorry about that.

