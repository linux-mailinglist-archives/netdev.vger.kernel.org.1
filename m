Return-Path: <netdev+bounces-52861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF5D80074D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD7E1C20AD8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CC1DA46;
	Fri,  1 Dec 2023 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FMjZgsVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7DD12B
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 01:40:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a184d717de1so256143166b.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 01:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701423637; x=1702028437; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=RxV7uY5cndZ8gVvvHBGuynsrgK6rQa8uI5lCXiOByio=;
        b=FMjZgsVZ5n4L49BIxiONH/6zX+9DbUGua1XFqyivWYOmhgmsXAGuXsrkrDmAZdfyUE
         Fprm4UupM45KFBIdprVfyMoF6E0Vq6PTpzD1ExmwbMsZ8j0tlP/fR3HpWuloLmCPaTDl
         pTV73l5Ab5FnLWXJjcjLWrGmnLxIsRQOZ14lTYQt77b4U4FyVern0cCd0gPZBcQ+8aOU
         CVSMZnUTb9q0xxpQ1p+moPoQA5PLhtQikhUWHnF8FPbobe1dliW5ovTIe4ZzIH7YEmG+
         upomhpZW/sp0gcTA9UP4v82Y9TrSq7DeDNFr52kVLJD2EEbsCH1laCI7lS7xdzQAyaKX
         pPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423637; x=1702028437;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxV7uY5cndZ8gVvvHBGuynsrgK6rQa8uI5lCXiOByio=;
        b=f5/roldsgNy7zujn4/MGgJ1PbaLNUaHEhNd+lR8hV3bgDvC7MIey3sfRs613b3eFBu
         XrB3lADA/Hkssi2NJavvdKO0XFkbSci48R1M9hHf44VlrqE33tdP9E93WxxLhdtjKdD6
         VocLjqoBtmIXeyi8UTN5JnsH3Dwj2BJ+yIYK/g3M3PJizjGJuKm0qq3x6bj9GRAW5/pz
         fWViJIIwUuUxp4vgcrjiXGwOD6zay6LFtfVT7Guaj33syb/0kV+3UkILewRSARDMVp8u
         aFW4yYF+IPT4IuUgRk7S2EEgU3E/mWqinRRPT61VtJPTDg5j+27pvEiATosXbkLErALt
         fAOA==
X-Gm-Message-State: AOJu0Yz0CNh0spi0N0wRhTnvnjX/bqYDDI36izV7Cqw37v4yHeSElYnv
	4s2hBoSBtHqIDJzqLFtcxDXpl11mFajlND73bM/CgA==
X-Google-Smtp-Source: AGHT+IG6Vv2EaOyMPcb68zhQSpKCoKIV1XA1+FtJu2iCKIwbXC1JEOb9Od3j3/YGMkVGr3RYoek1WQ==
X-Received: by 2002:a17:906:3f5c:b0:a19:a19b:426d with SMTP id f28-20020a1709063f5c00b00a19a19b426dmr367380ejj.216.1701423637230;
        Fri, 01 Dec 2023 01:40:37 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::49:54])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906279500b009dddec5a96fsm1703152ejc.170.2023.12.01.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:40:36 -0800 (PST)
References: <20231201032316.183845-1-john.fastabend@gmail.com>
 <20231201032316.183845-3-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: kuniyu@amazon.com, edumazet@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] bpf: sockmap, test for unconnected af_unix sock
Date: Fri, 01 Dec 2023 10:39:20 +0100
In-reply-to: <20231201032316.183845-3-john.fastabend@gmail.com>
Message-ID: <87edg62rcc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 30, 2023 at 07:23 PM -08, John Fastabend wrote:
> Add test to sockmap_basic to ensure af_unix sockets that are not connected
> can not be added to the map. Ensure we keep DGRAM sockets working however
> as these will not be connected typically.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index f75f84d0b3d7..ad96f4422def 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -524,6 +524,37 @@ static void test_sockmap_skb_verdict_peek(void)
>  	test_sockmap_pass_prog__destroy(pass);
>  }
>  
> +static void test_sockmap_unconnected_unix(void)
> +{
> +	int err, map, stream = 0, dgram = 0, zero = 0;
> +	struct test_sockmap_pass_prog *skel;
> +
> +	skel = test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	stream = xsocket(AF_UNIX, SOCK_STREAM, 0);
> +	if (!ASSERT_GT(stream, -1, "socket(AF_UNIX, SOCK_STREAM)"))
> +		return;

Isn't it redudant to use both the xsocket wrapper and ASSERT_* macro?
Or is there some debugging value that comes from that, which I missed?

> +
> +	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (!ASSERT_GT(dgram, -1, "socket(AF_UNIX, SOCK_DGRAM)")) {
> +		close(stream);
> +		return;
> +	}
> +
> +	err = bpf_map_update_elem(map, &zero, &stream, BPF_ANY);
> +	ASSERT_ERR(err, "bpf_map_update_elem(stream)");
> +
> +	err = bpf_map_update_elem(map, &zero, &dgram, BPF_ANY);
> +	ASSERT_OK(err, "bpf_map_update_elem(dgram)");
> +
> +	close(stream);
> +	close(dgram);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
> @@ -566,4 +597,7 @@ void test_sockmap_basic(void)
>  		test_sockmap_skb_verdict_fionread(false);
>  	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
>  		test_sockmap_skb_verdict_peek();
> +
> +	if (test__start_subtest("sockmap unconnected af_unix"))
> +		test_sockmap_unconnected_unix();
>  }


