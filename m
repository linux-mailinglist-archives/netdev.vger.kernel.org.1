Return-Path: <netdev+bounces-160992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFFAA1C85B
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71D71885F4A
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF96154C1D;
	Sun, 26 Jan 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SfPLm9Rr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77313F434
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737901013; cv=none; b=ZPzEEK18hC7UDjm+jx5Byx9gj0/q0VJKs1baz/DmTxj3S+rpLxWigHEwBVH5zkzxduIkAYW8u92Wq8WENjSv9Ek1324fO3O5x4B5aLcHw2Ves7JrQm7XoJjPRcUIxUJjFnGJIGj76Fo407GxAcjdbtyi+0bpYFGSflGnEHgY+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737901013; c=relaxed/simple;
	bh=Rws2a+wog/8MrdQQ3e+bdf6U7//EDWF3+LxC1t1wN/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvzqC6yoUecLMwdcJxJdGJYCWlZNMo/CskpYlcajsencflg/0dMuMLqYTNVttBPoVO004TG3lJ2AgKes5xTkMclCi3vop2C/Af2NWaz3x48pynxcD6hKXvv6luQMx5NHioNEE/IP2bRgPMB+gGtWCOlF6EPC9RbCPnRktf4PJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SfPLm9Rr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaeef97ff02so610397766b.1
        for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737901010; x=1738505810; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rws2a+wog/8MrdQQ3e+bdf6U7//EDWF3+LxC1t1wN/o=;
        b=SfPLm9RrjR1fW0DBuNtzJCIgxPOzfGtZIWspdanpgbrl21jEQeKKBxWRQ4Gsl9x9Us
         35HlXiAr1Ui7rEWW39Zt/pe/i3dj7nmGGYN959ITd/GXHaKBXvbAEcvcPNionwDD89sN
         YeAvE2Pv5W/Jtnnjt/2a7kkWn/epk7D0Gl5SIABuPilLU0luaqfrzbFoiPAs1Le62i1S
         WE+c2bwBPHVEfDAHvTN6YXcK+s9/JxSwRMK8Ds6I1muwG+UrW7WN8gcUwi1ltVCZztSd
         D7ni9M00apXz4d3yRzJ7VuVCnir8RJFEg6zPkNg20crNKh91JnD4RcHkiMqiQPara91U
         daDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737901010; x=1738505810;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rws2a+wog/8MrdQQ3e+bdf6U7//EDWF3+LxC1t1wN/o=;
        b=cIjgMipJRMZaHxlkHNaapMx1p5mMFEAV9dez1pDx9r3dDJOOgwjPD9DPX8AJe23bJg
         RgKffgeHkZWTwdvuLscuwnbvq02+Mn0SU1Ugjtztculs7h3G9mmniPXjWgjSqNYclvLA
         wjGOsY5TNXuASjlV6VIkaNLfVWTJmGOpvbUaba3suuu8Vs9Oiv8MBaUhQv4x+MQwCjPe
         ZKhlf5wULINsBBgSwVb85HnaY0GGSGiEvoQqH7uVncIwq/IvgrbS4xMgyi/Hq/lsa2E0
         RRDtsxak0YExZIDXFOB8OfHdxHAeNJ/QzMBx2SZCcfl9aBX4vJzqUFTRCUsqhgvplHdF
         pFZA==
X-Forwarded-Encrypted: i=1; AJvYcCVl1gYQ9Q7V6C0DSJxs/pO/MRXTlgpficaIgLcY92gAz6txaH7UJ482JUloxc2OHRwG8L1LMfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBDgZUSkrXyqwqbCtCHGXuQCGvO1meb1zCrCBhMvuJWg2ieD+
	80o0ZndnH66UlGYCFRnJMT3hSy/kpVQVyx0YghC4pVW6skVKvNJI9t5nuER5RP8=
X-Gm-Gg: ASbGncsE7llqJ2gwVo2rtZcklb6qp5ah2xwZ+u/IU7KDXmzHH5FCvN2AvMJ/22dUCfR
	VPNFlRphTWvHU3hILnHp3pkGY8B7KdbAIddWjvRjcbKPiuqX8ZT5jveLAMbpUtsi4UizmHqrVy8
	jeYGYEtyCgMxvHEzQyGIpLCG29TXVyqOrfn/r1V8Vi46mrMumEO5xiWeIAs2WRsAZX2doIWZ/Lj
	MNeVEdKmBuvjuISMd9oHcQk3Vv4/De5etAGAyjGLJin56AkI98Po9TiHHQ73qNl5YFWLTC/EA==
X-Google-Smtp-Source: AGHT+IEtEozd4ZbHmZSXMJeEU/z3POYgpvsYmnTf9qF0iv5ALo2LKCWSk1rqIWjzzlS5YtECkNssNQ==
X-Received: by 2002:a17:907:969f:b0:aae:8495:e064 with SMTP id a640c23a62f3a-ab38b44e119mr3607839866b.40.1737901010016;
        Sun, 26 Jan 2025 06:16:50 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8ae96sm424145466b.80.2025.01.26.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:16:49 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 0/5] bpf: fix wrong copied_seq calculation and
 add tests
In-Reply-To: <20250122100917.49845-1-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:12 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:16:47 +0100
Message-ID: <877c6hd5io.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> A previous commit described in this topic
> http://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
> directly updated 'sk->copied_seq' in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
>
> That commit works for a single stream_verdict scenario, as it also
> modified 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> to remove updating 'sk->copied_seq'.
>
> However, for programs where both stream_parser and stream_verdict are
> active (strparser purpose), tcp_read_sock() was used instead of
> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock).
> tcp_read_sock() now still updates 'sk->copied_seq', leading to duplicated
> updates.
>
> In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
>
> The issue causes incorrect copied_seq calculations, which prevent
> correct data reads from the recv() interface in user-land.
>
> Also we added test cases for bpf + strparser and separated them from
> sockmap_basic, as strparser has more encapsulation and parsing
> capabilities compared to sockmap.
>
> ---
> V8 -> v9
> https://lore.kernel.org/bpf/20250121050707.55523-1-mrpre@163.com/
> Fixed some issues suggested by Jakub Sitnicki.
>
> V7 -> V8
> https://lore.kernel.org/bpf/20250116140531.108636-1-mrpre@163.com/
> Avoid using add read_sock to psock. (Jakub Sitnicki)
> Avoid using warpper function to check whether strparser is supported.
>
> V3 -> V7:
> https://lore.kernel.org/bpf/20250109094402.50838-1-mrpre@163.com/
> https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
> Avoid introducing new proto_ops. (Jakub Sitnicki).
> Add more edge test cases for strparser + bpf.
> Fix patchwork fail of test cases code.
> Fix psock fetch without rcu lock.
> Move code of modifying to tcp_bpf.c.
>
> V1 -> V3:
> https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/
> Fix patchwork fail by adding Fixes tag.
> Save skb data offset for ENOMEM. (John Fastabend)
> ---

Thanks for addressing all feedback, Jiayuan. Series LGTM.
Feel free to carry my tags if there is another iteration.

-jkbs

