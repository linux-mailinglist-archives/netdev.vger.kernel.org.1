Return-Path: <netdev+bounces-293680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIOoGb1kHWqwaAkAu9opvQ
	(envelope-from <netdev+bounces-293680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E450D61DEB2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C02DD3085525
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74623921E9;
	Mon,  1 Jun 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="atPaxXrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94127213E9C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310712; cv=none; b=d2NN9AxjkVsEijXj/6lg/+CuvsJUykCWoNsOS44weQr78E2nuo865ly6TRRx5xNj8RbEor5L6GPbefeelu8WQ2pM3+UK0CJastWRspS35K/uJ7QB2tEnWuIinGkVxEIRz3EaZHhlknUoG7EcfkpUz5bFs8ry4vnSY9wy06to/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310712; c=relaxed/simple;
	bh=C5labr5TltnbCZFWev2l9J64VPXKI2fHbdqayl0yXt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OEG+1+454S+jfVl4pXrqIrkaGLAq+a4Qyi1TSoAJEh3R8KRf2dIwQ49cg/WJWCt7/tQ5SOqxSog8HfX6BVOiun54Y1nzhdFCKOsFXrqmEzO1wcvVu20K7pnyxfahpZGlmugAzGQSeHKrFG6z4XgybHEvbNgFgCMDHeBlHh05IaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=atPaxXrF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso13026729a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1780310708; x=1780915508; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5labr5TltnbCZFWev2l9J64VPXKI2fHbdqayl0yXt4=;
        b=atPaxXrF00+u8w11dIneZFlXxqDi2Iu5BPf7l0ULaEoZcmgJ0xD9Qxgqv6eEolppIm
         NMotulOPAOg+qTxA8VjvxwvopnEJ0hvbiVE5XuE9Amxy4lS3ZJN4sjF8AtFVtncLWGq1
         Mt8olpuWpUhzIyDGMiiCsCcys+PE9EFywey3A89MI/YtS7Q+YfBLfTuFAtHVSwHoMt1B
         Dop7lUKSLDghY7RpgPMTMWY+h+SX/ghBZLAc1kcns25xmPEjJkfKyHKyzwwBLPOpqwYS
         R/sZyfCM6a2zOlu1Rz5RwkJkxFKzVjofSLBhoySnStkmaxI5P3ny2LyXKP09zZcFG+Vf
         bptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310708; x=1780915508;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5labr5TltnbCZFWev2l9J64VPXKI2fHbdqayl0yXt4=;
        b=lnMahxncoUCpmY3e6mj9fwfNDAcwk/kk4DJpf+PCAqNr6SkFjwGy16FqHfYXustKtw
         x0zgHCsBi7HMD3zeXyILmzGR+Wh7g4gMgDQ6bqCXdAMEziDVNqaTgR0z4liUNjqrZZzB
         mwpRU+RVywdNYod8yJpw+VWykBjmizMzlaR5uYTXIY+4V1UKuSNIybfOqUMgDnLMa5yh
         RMSwx6fciai1lxzxg2hJ3+JhR1MZbEUyPJSRDmvU+OP8wX4dbI4i/5RyrTfv8xdziiea
         /pp9cazcNlFqSSajrtjKJh+ZIkkV6b0lTo3fazO8Ddg/TRxqcRIE0n7B2P+FIecyUbck
         jPhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zBUbp05XQ5OANjvEW1Z4gsiqGCJG88nw8mxgR5XIUQ9q6ERD1+PEnD0GyU/aGt6BOUS5V9nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/l+NgknXw/rvRDRiTRNRyt6RSB/GqrbTnWdFNrjU2D5LMfM6r
	6VHc5G2zgWlYaxFRwHqf5mXuZUyNURLCioYIW22ShRCHoh9ulpseFRX+NQ7USXyDUGw=
X-Gm-Gg: Acq92OEyG/yHF47p2EIB1wn8JJd5VQElsV5lVXbnd99ECrCYarmVMam7GY+qdqGhyei
	QOynmWopGawTjAfgbyMQj/xoYY0WZDxO0IynxgkxYTeQabxVVGRn9Hvn20RSSljNj6sKPFh6upy
	6kDrtohzOP9tf2vSFohR5vL3iP+gmBGpUK0fDWXMmgb7PWAyrk4DuubXwgSadxSzAXS0UU/E7RY
	8LUPTgCwzEWx5Xi9Ei4r8GnmAE13AJcDOS1dGhRmUnrvIlRO0G7yB7Zf3UVIw2KcHdvSYE/5hBU
	or3MpZunASEluOlVoe79ZLYSCel1sD/+FoQGzotuaZ/u+t2HYtbmYeT7UB70dhkEZl+0E05ICFg
	uXkEA2nt9XVfH5YUYhkggw61BQqEZxZ8ZW02ouuxLWocUp4HdoKckrlr2XcT6WJsDr1+vnx5DqG
	p10wXjO6Jyv9G0rE9nDKcTZFjDm+PzdpUPeSwB9LRd3RW821k=
X-Received: by 2002:a05:6402:a50f:10b0:68d:4284:1821 with SMTP id 4fb4d7f45d1cf-68d42841a88mr1541715a12.4.1780310707721;
        Mon, 01 Jun 2026 03:45:07 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb79188bsm1814610a12.3.2026.06.01.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:45:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  Simon Horman
 <horms@kernel.org>,  Lorenz Bauer <lmb@cloudflare.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] net: Annotate sk->sk_write_space() for UDP SOCKMAP.
In-Reply-To: <20260529193941.3897256-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Fri, 29 May 2026 19:39:23 +0000")
References: <20260529193941.3897256-1-kuniyu@google.com>
Date: Mon, 01 Jun 2026 12:45:05 +0200
Message-ID: <87cxya5yku.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-293680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,cloudflare.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: E450D61DEB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 07:39 PM GMT, Kuniyuki Iwashima wrote:
> UDP TX skb->destructor() is sock_wfree(), and UDP holds lock_sock()
> only for UDP_CORK / MSG_MORE sendmsg().

Nit: lock_sock() serializes map updates via bpf() syscall. We also have
sockmap iterator programs which can insert UDP sockets into sockmap. On
this path, sock_map_update_elem, we grab only bh_lock_sock, so the race
against UDP_CORK / MSG_MORE sendmsg() path also exists.

> Otherwise, sk->sk_write_space() may be read locklessly while SOCKMAP
> rewrites sk->sk_write_space().
>
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
>
> Note that the write side is annotated by commit 2ef2b20cf4e0
> ("net: annotate data-races around sk->sk_{data_ready,write_space}").
>
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

