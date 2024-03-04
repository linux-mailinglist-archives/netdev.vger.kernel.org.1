Return-Path: <netdev+bounces-77009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24A86FCB6
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65499283CF1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565B1B277;
	Mon,  4 Mar 2024 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCfyZNqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72B1947D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543213; cv=none; b=Rl5P0TpkNAKv+URSGxv+Jpf6tIOqDbY/w7VaKMDjDu89pbQ6qoZZ0kZnNfS1acIYIecQwKH4YPW08EueoSs35XwKjfbqs6iC2w5xVtBOzfldzqZUeiH9qyUF87rS9ad8Y/Pqopf6j1ZlQnpc7rU9EnUJMsI6REQRx/hcckNwSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543213; c=relaxed/simple;
	bh=vBrkPWse20aBnapGCTZU9TOwaXYkrVP191wlglWf4XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR40YcjiZZN5pL1b+/UllhxNm/QDpJEbeppRWe8eXctTSMGt5E9euxwsT//bbIkUoCqpET3ISz0o7HUNZClCCbpZ9dVifRqhjVURhs7nJFNXeaMR2Ei8KIsNihSHm8P8JUune+oieCRiyQYACmLss/ph0rvFMLTbky/zhL7dRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCfyZNqT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso24307a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709543210; x=1710148010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DAvi4nhfE77zJ0ZkcTqel4QoSRB9T2Trc5SCXb/MW0=;
        b=SCfyZNqT2t51ZZn+rcjJFoL7KNB6+ye7+cbtWDgMfOl7voobROl6+Oop9nQ/lSF8dH
         jk5TIFO44GVQAjT/n+tFOUBw/wChxF1YgGj6dRQAPL/yCFGsaLpdv0C0RKr0Fn/WN/+G
         We5UOPnDV14NKZyR5p/RDf1tlxkaaDh5XgUlygl+XTt4ZIJ3AkPbcK0lxQzqxsA9Qwrn
         OIPDAY/hUsuwAmSV5582N4RPgJCLktAmqM8xca6UShaFVPIKreA257P9DngzS9y7+OWY
         V2vcNTgrQcACnZSqQsp36ztd/0fvKRpTiTxeV3JA5IY4zzGjapgSAY60lRIZnOsThopk
         1/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543210; x=1710148010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DAvi4nhfE77zJ0ZkcTqel4QoSRB9T2Trc5SCXb/MW0=;
        b=WBr8x/odXS8ZtNKdB07Y3rh1zAlrp0L0GgydfmbhX4iIor5pPR5cM0XoY96KJ8k1I4
         mkD8hvaWTzW1XFTfP+LtsLc84jJJYp/QjUjPLhoWkSo9U2K6xr1v3GDHJGcsfPg9DKO7
         phLfmyUxMwrUpJcaxOerPh5/WDsbdO6ChQOMLQbz9xgG2rH6I6V5zGiqjIM6I4NA+8vO
         jt6xrB8jlF121x4qlwJJQEbveJRg5oGWyVccb6AivQh+3zyrp5VAySfy+Nw9/1XvNyEr
         oBd2UAPaR50rAlyyRefCUK0W6KiIrchwVs7u41k6hwLGwegbrP+Y5cKEe1taJhe35a2E
         U/dg==
X-Forwarded-Encrypted: i=1; AJvYcCWPpB9uGifixQyspWeSrz+gwgIwRpT/Ow37tclSFn9+Me77e2AczW2OVV+5ODJdNecWXtz6pJnQvCoHfE35C9ePSitcwvfk
X-Gm-Message-State: AOJu0Yx9eAPoVBaj59/LtOxRLqWWJeybFyPMVxlN6pZ43/40AzJTaPno
	3drQvRHIF3w5rcU2ilXyTEB4iRuO+517oArMQGBwgtF5FcjwlbZH++dh3g6JrIS1zW4CNjsXFyi
	GU8WjZBtocaohIAWLW4PjgZjw0pvx9XMBXRJf
X-Google-Smtp-Source: AGHT+IH1eC6Z2LEwotQkFxKWJ8sBu8r7TknbQ0eI3XnixNo1JMvF46Ydhm4nu7G6nbEEbiiE6Yv5Oe0GTdN02yfBBYM=
X-Received: by 2002:a05:6402:26d4:b0:567:dea:c3c5 with SMTP id
 x20-20020a05640226d400b005670deac3c5mr201458edd.6.1709543209658; Mon, 04 Mar
 2024 01:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193740.3436871-1-edumazet@google.com> <20240301193740.3436871-3-edumazet@google.com>
 <f8711f5c4d6dfae9d7f4bf64fdde15feaee56494.camel@redhat.com>
In-Reply-To: <f8711f5c4d6dfae9d7f4bf64fdde15feaee56494.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 10:06:38 +0100
Message-ID: <CANn89i+19QU3AX=9u+x51P0xxPt6sNj-GHUh85NF0gsBChEgvg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] net: gro: change skb_gro_network_header()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-03-01 at 19:37 +0000, Eric Dumazet wrote:
> > Change skb_gro_network_header() to accept a const sk_buff
> > and to no longer check if frag0 is NULL or not.
> >
> > This allows to remove skb_gro_frag0_invalidate()
> > which is seen in profiles when header-split is enabled.
>
> I have a few questions to help me understanding this patchset better:
>
> skb_gro_frag0_invalidate() shows in profiles (for non napi_frags_skb
> callers?) because it's called multiple times for each aggregate packet,
> right? I guessed writing the same cacheline multiple times per-se
> should not be too much expansive.

Apparently some (not very recent) intel cpus have issues (at least
with clang generated code) with
immediate reloads after a write.

I also saw some strange artifacts on ARM64 cpus, but it is hard to say,
I found perf to be not very precise on them.

>
> perf here did not allow me to easily observed the mentioned cost,
> because the function is inlined in many different places, I'm wondering
> how you noticed?

It is more about the whole patchset really, this gave me about 4%
improvement on saturated cpu
(RFS enabled, Intel(R) Xeon(R) Gold 6268L CPU @ 2.80GHz)

One TCP flow : (1500 MTU)

New profile (6,233,000 pkts per second )
    19.76%  [kernel]       [k] gq_rx_napi_handler
    11.19%  [kernel]       [k] dev_gro_receive
     8.05%  [kernel]       [k] ipv6_gro_receive
     7.98%  [kernel]       [k] tcp_gro_receive
     7.25%  [kernel]       [k] skb_gro_receive
     5.47%  [kernel]       [k] gq_rx_prep_buffers
     4.39%  [kernel]       [k] skb_release_data
     3.91%  [kernel]       [k] tcp6_gro_receive
     3.55%  [kernel]       [k] csum_ipv6_magic
     3.06%  [kernel]       [k] napi_gro_frags
     2.76%  [kernel]       [k] napi_reuse_skb

Old profile (5,950,000 pkts per second)
    17.92%  [kernel]       [k] gq_rx_napi_handler
    10.22%  [kernel]       [k] dev_gro_receive
     8.60%  [kernel]       [k] tcp_gro_receive
     8.09%  [kernel]       [k] ipv6_gro_receive
     8.06%  [kernel]       [k] skb_gro_receive
     6.74%  [kernel]       [k] gq_rx_prep_buffers
     4.82%  [kernel]       [k] skb_release_data
     3.82%  [kernel]       [k] tcp6_gro_receive
     3.76%  [kernel]       [k] csum_ipv6_magic
     2.97%  [kernel]       [k] napi_gro_frags
     2.57%  [kernel]       [k] napi_reuse_skb

