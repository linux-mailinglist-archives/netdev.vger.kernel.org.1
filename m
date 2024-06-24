Return-Path: <netdev+bounces-106155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893B914FB2
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163B3282021
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0D13C9AE;
	Mon, 24 Jun 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MWpGz8h/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3429137764
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238555; cv=none; b=n4OrYmDTFp7xAGD3RojicFD5M8rcIeEwllWkO37wuo19cbvNq7qL7NPXqJnzn72NyyLRvgEFifvamKJ4HKGfrDK7cy6LMnasSnyXotTL0V0VYKE6bycmiL3IwdRgB5dFUX5ykH14zOokwk/q2SbKEYAdkOt0t2l72ohmLMxhLeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238555; c=relaxed/simple;
	bh=WVHqXy9ZInCaWH01/8bWggSAo5eLlmc2jeeEEydVT3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKs51C1cX9rnkSIb0aXqbQLJ5L/UejLVXKtBuYfgymtwkB6h4vK86JGKW68EvE0qheoE8v6IUCZvZqbV5bBzfNO8U36P+T/SoOJPV3k7beJm8vtvsTZczKj4C8Uu7hdIoYFe9dSCN3F6eYe2gAWhNSCm28J70YLeCiyWD52mUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MWpGz8h/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a724598cfe3so199740466b.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719238552; x=1719843352; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVHqXy9ZInCaWH01/8bWggSAo5eLlmc2jeeEEydVT3Y=;
        b=MWpGz8h/K50vTi4PBRNp3Bbnr+A+Jt8r/PWvLao49oIyhLfzSIG+b3ZC9oz2L1xeSi
         kvQJZo5wQYFb54ihY3Spwxf3vpbpwFSMeewfs1iC6pDId2cGgO3v3ZZ9vl8xxeO6FbuI
         cYZO4Z1zi3sVsmVF/Fvj7ZlYOh6ZfBOu0QEE/jx6ZjjUQB+ALex+cCmiNQt52cE4ITMy
         USxy9qTJZRyYLxhb2MzH2o+7JUqVT5NTN0qhgstg7Sy+dbVUmxW98wkn51Mr0WBgI06G
         1EIBl+FjfTsm+o2RfgXlpH53Waxk3/Co0LwNADtNtQyFTVdwRIHFzyAncVNvB3g0irQl
         h0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238552; x=1719843352;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVHqXy9ZInCaWH01/8bWggSAo5eLlmc2jeeEEydVT3Y=;
        b=Mcyx6W87Nvg92yXTDbgI1WAA7FRGkXBOTUJgcTMnKmw1UDc5nKzDfg8VKDklnN5fVy
         c+PAw58hZA1UmwhYtlppt6LDlvzWOFtG+ZX7Fj3jbLayfOf1ej9Yfo81CZ0zx9Zd9eos
         /VnKdIA5nzRJ0orllnoRer5wMdUT/WkbvyBi64xEuRbZu+/TW1RDf/p1GxM9PF7za5Ng
         6+ITCPkiUeZgKUTuUguXzZ/oDHIg3eihzILKbAJsdf34oUYzAqRfJXf0itizsWMHRm3J
         zi8JgPvxZxhk1zGAH8e97ziB7OrhPuSjawbIUohAXNYHKPpcoDrVJzTpkqZgHjEoIu2x
         fKeQ==
X-Gm-Message-State: AOJu0YyOA/rhKOwxz9/dj40Nvkc4CREJKPEVnnl+mUite3XgDx3omQNA
	ntMusDHwUYj8Ym2+r7eZmX4KBa2dTJ5ktHbn1uXvM+p+t51aC3NWIRwzijfFsqo=
X-Google-Smtp-Source: AGHT+IGOFPUZG0DHZAYy6V/GZR1AuVwIqcOt9IZJ+hY+ERpVLG4G+3pJU5NB/1fgzXE8F1KYVann4g==
X-Received: by 2002:a17:907:104c:b0:a72:455f:e8b with SMTP id a640c23a62f3a-a724599a00cmr356126066b.0.1719238552027;
        Mon, 24 Jun 2024 07:15:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7263a345f6sm20137766b.46.2024.06.24.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:15:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
 Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
In-Reply-To: <20240622223324.3337956-1-mhal@rbox.co> (Michal Luczaj's message
	of "Sun, 23 Jun 2024 00:25:12 +0200")
References: <20240622223324.3337956-1-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 24 Jun 2024 16:15:49 +0200
Message-ID: <874j9ijuju.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
> with an `oob_skb` pointer. BPF redirecting does not account for that: when
> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
> results in a single skb that may be accessed from two different sockets.
>
> Take the easy way out: silently drop MSG_OOB data targeting any socket that
> is in a sockmap or a sockhash. Note that such silent drop is akin to the
> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>
> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

[+CC Cong who authored ->read_skb]

I'm guessing you have a test program that you're developing the fix
against. Would you like to extend the test case for sockmap redirect
from unix stream [1] to incorporate it?

Sadly unix_inet_redir_to_connected needs a fix first because it
hardcodes sotype to SOCK_DGRAM.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c#n1884

