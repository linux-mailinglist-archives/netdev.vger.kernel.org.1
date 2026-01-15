Return-Path: <netdev+bounces-250059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51FD2362C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA59F30434BA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F735771A;
	Thu, 15 Jan 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jv5x/Lw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58428357A28
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468553; cv=none; b=JxLzDhRdp+tHBgsciuGqNk6PH1fe9uhnWC2ZkBKFUtWF6oJ5ioQm98wNALQlz+BuPpeDsMT7A2//Bo+5ULwMXFY08TVL5XpwAXTnZv6DNulA1m7NrU5SKAwo9Mzo8W9BODIoaE9X1ILNAzMi8miTYblJH/DALK7cC/sXUQxe9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468553; c=relaxed/simple;
	bh=gtMeMIiWZfR1FPtMNs15Lf/g6JMp2RzBjrLoGR7//dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL+mLn2bgU1BdnJMKqzydu1UyJCvqNDQKYNXyva/G5lRshb3Ms1NuhaK7qhlHPHsiYFMZdvYsNYFvk0g1TLrvn6axWGC7GZRYtO5/tLcNIPLRZx6sknUeFsrhvgojTlcb3DPyqu+/OvT368+5qPnsBGe4icrB+vQ10RjOPlj+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1jv5x/Lw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5029901389dso2882351cf.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768468548; x=1769073348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LJoalJ/bPq/SwT2K8wCn2gybGfkpq32wbnQ3LM3Vlc=;
        b=1jv5x/LwZ4womyiZUsDHisqA1CI3EUWxOSDb02YihrPIjFOsV6ERhnOOAS0E7eNtzg
         6PyGXm978pbxe4Wc9CFwoBk32LyaeVRvWgOCzBDOofJ1RF3WP42Nmks32d+yNSZPpWCL
         mOQRidsINSw5VUECGkBPqL/PCkHT9UB1V10imoEhXWKJ4qoSwlKCm97Tz/8QeLCJTIIn
         2VuovK8kyPRRI7tgo30DZ15s/tP8HYo06SBkVMtpHoyaPkPcHm76Gi+/DB8YMd2/fEdU
         H9EbgSLpvM7HGDB1N/lTphjiQ692vJ0HbnYTrpig3HIzz2T5hp6wJHjNkyXOGXisUNLZ
         UnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768468548; x=1769073348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LJoalJ/bPq/SwT2K8wCn2gybGfkpq32wbnQ3LM3Vlc=;
        b=WBR3UNFJHduyAGpr9dZTrzqX14HLfaZtKBNgyBcTDFwgiZeABx0D8pnj+jrOVr072K
         NKvosyNfqi9VLWoUDhUPEvCn6FudTrULVxAPdtfNeS+lmS02+2uNnoTPWqP3R+J6NR/w
         XjVr0FkdNvURpfZ4A9ZENwde6jAydkyhoVYEnXBdllGr/OQghcOibb3eqy8dbbvqkxWd
         8rq+ojZIIKQjrNli6K27V11LjRJTpGvpZT+KqTN5D6vRAzaPADDTTy0oKrvt3k6v/Ure
         MiwlkBcEgMaUxz4FBeHcPAZB9edmtPGbzjrsNpOWZC61NSlD/OYJnhevLWXAY/lPjIDc
         j1ew==
X-Forwarded-Encrypted: i=1; AJvYcCX3FksSZfJ05C0XoCCCoAzkK6U8pVLWjspZNZey+HPcin9rR2hAATobbuN/KrAunmPtOj2h0es=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIvrH8KAJeLsKC4OGW6nC2jQa9nJXuwwbovRscZ0fQJh+yEv8
	/Ht0H/wtySJMkyWEE5M8hZyIwAp8kw5tjA2JGVXehNfATVsxlLtHgh8p2qjHHKNUgLKi7mXa63r
	7CqpZsi7On+Z8deaM8dxMT9N8xW+eGPf0YniIhiaF
X-Gm-Gg: AY/fxX4MUsxKQd7X0UIiBugqAbNGO4Xxd7xy0AGeiMiCsgLvZ4sGzNAzrcJ5CYb54Uq
	cTq/9/cVorywuYKpwd+ksf0mNZrYeQHXx14EMI7zb6AG+Xc0BczgR+Qsb6rC+9OPkJ4X09tUKEr
	kZuMjOlwnf1ZQjxAR1F4HvUtwiHd0UDkgokmLeVId3zMi3Xgz3mkyqurNPMvRw4+QObfkKvOhPz
	MUy0viwZ2A8yxr2xIhSnZsWNpKxIYDZCK7Z+gccLMaMmF91hjuVG6UMspMWJmbSbv1JfA==
X-Received: by 2002:a05:622a:199b:b0:502:9bdc:57e1 with SMTP id
 d75a77b69052e-5029bdc598cmr6774851cf.2.1768468548067; Thu, 15 Jan 2026
 01:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115033237.1545400-1-kuba@kernel.org> <20260115051221.68054-1-fushuai.wang@linux.dev>
In-Reply-To: <20260115051221.68054-1-fushuai.wang@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Jan 2026 10:15:36 +0100
X-Gm-Features: AZwV_QhTCMDKh5q0J0qjsf9QjxWK4VZqifJza4JSZzX25aIAu0asXhhTMuuhlKY
Message-ID: <CANn89iKfuXjqKsn+xB6bpGOaqM7pN4ZcRJ=2KJg4WY76ArYXhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] wireguard: allowedips: Use kfree_rcu()
 instead of call_rcu()
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: kuba@kernel.org, Jason@zx2c4.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, vadim.fedorenko@linux.dev, wangfushuai@baidu.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:12=E2=80=AFAM Fushuai Wang <fushuai.wang@linux.de=
v> wrote:
>
> >> @@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *=
node, struct mutex *lock)
> >>      if (free_parent)
> >>              child =3D rcu_dereference_protected(parent->bit[!(node->p=
arent_bit_packed & 1)],
> >>                                                lockdep_is_held(lock));
> >> -    call_rcu(&node->rcu, node_free_rcu);
> >> +    kfree_rcu(node, rcu);
> >
> > Does wg_allowedips_slab_uninit() need to be updated to use
> > kvfree_rcu_barrier() instead of rcu_barrier()?
> >
> > When CONFIG_KVFREE_RCU_BATCHED is enabled (the default), kfree_rcu()
> > uses a batched mechanism that queues work via queue_rcu_work(). The
> > rcu_barrier() call waits for RCU callbacks to complete, but these
> > callbacks only queue the actual free to a workqueue via rcu_work_rcufn(=
).
> > The workqueue work that calls kvfree() may still be pending after
> > rcu_barrier() returns.
> >
> > The existing cleanup path is:
> >   wg_allowedips_slab_uninit() -> rcu_barrier() -> kmem_cache_destroy()
> >
> > With kfree_rcu(), this sequence could destroy the slab cache while
> > kfree_rcu_work() still has pending frees queued. The proper barrier for
> > kfree_rcu() is kvfree_rcu_barrier() which also calls flush_rcu_work()
> > on all pending batches.
>
> We do not need to add an explict kvfree_rcu_barrier(), becasue the commit
> 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destro=
y()")
> already does it.

It was doing it, but got replaced recently with a plain rcu_barrier()

commit 0f35040de59371ad542b915d7b91176c9910dadc
Author: Harry Yoo <harry.yoo@oracle.com>
Date:   Mon Dec 8 00:41:47 2025 +0900

    mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction

We would like explicit +2 from mm _and_ rcu experts on this wireguard patch=
.

Thank you.

