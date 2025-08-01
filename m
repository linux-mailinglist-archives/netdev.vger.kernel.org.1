Return-Path: <netdev+bounces-211368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B039B185C5
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766AA189990A
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6BE28CF40;
	Fri,  1 Aug 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXAEWxWb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC726CE2B
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065649; cv=none; b=UGpJGUBwr4Wfw8EE8ItjX+uqRhC5jluhDJ69oaiLJZ24Kc+rIJXR04vtRBizeqjGaWJEwHko0APj+kdVWCNrqOEt6LsE1nnFweoEEFRcWFSpJ354ZI6Zn+SCN0s1+8KMjrv1avg6QJatqIAdud9flHKE+piFvPTwZSNg8cRQNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065649; c=relaxed/simple;
	bh=LmwQUupYSQ5c5uv+Wg0TpH9+lHYtlOJKe2aOVLGnTKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIs5JwoTP4P9E9zapZtnP0FD2+jD8iyGACEnuLYS6TxTFcCGBQ9oxxyIKqVmZyJ9mDFvqGQ73xZhFH6SuHzqTehJB8HcF5W+L1IIC192kXc8Jslpbm/Sq/yvHwMpKC08nI+HvyG8ZjVlUvTgtoZoglWNEmay/qhFGXP2Ks94kC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXAEWxWb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b421b70f986so2000212a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754065647; x=1754670447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPlDNUMymhsODNFmsd1JRKJrfbGJJsVHVjtAtmZ8nro=;
        b=rXAEWxWbhPKRHKHuwGbf7t0NuR4fGxCfUeg3ZUD0uRB3TXzQQ6kl99Jax0WwieaUHG
         //X3tbfyD9qMFTFmm/SsMcXasGpWAn76SmlOz5dY9w0/U0NwiOKDDbMzIJi+TXEiaJPG
         KcVHoTt3Z6NwvJdgztg3KyobW7ArWZNOL+NEo0OrO7NLaNqDeoUgncR2dhSQQf2hhABp
         G3TbyJyv4zOyyMolEIJrLKov9Pmw8o3e/ixh34/47rALQal+FBMa8lI186ZXWz8QY8U/
         M4f5RdQtcrrk3Bgf6gnrCJXa8vVMQ1PyeN1FESRPZ/vCB74lyMid6XVqXuHWeGZ1xe1G
         EpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065647; x=1754670447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPlDNUMymhsODNFmsd1JRKJrfbGJJsVHVjtAtmZ8nro=;
        b=JCJaYtApomLmhwplb7XoYTejYZhVoYmGchMF70YEO6mKZcb7TfFGZ2EhbDWgxT9I/N
         SeqzAbSIO8rLlGbIvU4sWA5cpBvwyh9BhSbJ/mGf6VWAJMqFxqAFHS4PxgZtX7+fulzM
         6F6rn2NXP0telUfVOC4OU1sWgHQWv6aXfXa/ql7ZbXcO9gxPyt38nRhtn54dlMOKWePL
         t3UYMVcPOwm/8YRDrw/CYO+nA6UGTS5YZdYE9BrvzeXthv5bBObtIEKQEC8V8GzX3J/B
         XUpV4UGC999XmTquhmoKJ/KhKfuP5iwUYa5PS21L4kSg807qsf0K5AqH5mEW480G6nAw
         q79w==
X-Forwarded-Encrypted: i=1; AJvYcCVKEpHnKDMiHZs05K4kjrIlSU/LAQiaBB9mn6wMyu352zeeiWi0Oa+eYBcJtClbLU79Pd4eYBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEciH56CfyjKo4QltmLNwWmqsTPzCTico292kRmZHSJ9yTZWe
	zoJXN5SLVaaSpUDxCDZwgy+siafSwBf+KpsOUTSEUzI3x7WfEc57mID8H3pAJpB41LzN2qqnt/s
	75VlxH3zz/0C08muPgEI/qr086UMZCi7DKihYklyS
X-Gm-Gg: ASbGncvi6uCUBZVBh2AcoK8IfvLp5JppicDneclS/OxbHQMvalxvsLEKvdrEqANESRO
	o7qw9knaWqHYoOntR0zR8kmoyo9V3S1dDUWduXnNydOc6qaUvZCcZCjKfjlkkUXSK/KQxJVmX5J
	Nkm0zAa692pCD2RdwwQYSvU6n2K3gC25HjBI1BdTPe93201zBKwNtXJqlCm/0/d4iyvrQOX6W8+
	Wy9pKTgVpXVI1e6N0gcpPzakZSyPKP5mW7Ut2gdagUSod7Nb6Q=
X-Google-Smtp-Source: AGHT+IGrbCrNLGqTtBuWiAzE0+U3e1NMQB2FNpi+8gjkEuVtCmtDODuiea5OBd3jquswfNAUuJ4/jdmM5dWBSs9hwSU=
X-Received: by 2002:a17:90b:4a02:b0:31f:20a:b54c with SMTP id
 98e67ed59e1d1-32116115530mr791605a91.0.1754065646975; Fri, 01 Aug 2025
 09:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
 <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com> <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
In-Reply-To: <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 1 Aug 2025 09:27:15 -0700
X-Gm-Features: Ac12FXySWBq5tqGpyUdEEo4tML_igvMbcYh9DoXD653V26VGI_HquHEhRn-c55o
Message-ID: <CAAVpQUCf=xHc7nx5Y5rZ4PcPt+PN9kdWvGo5jzRyNkubq-sRYg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:00=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jul 31, 2025 at 04:51:43PM -0700, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > Doesn't that end up implementing another tcp_mem[] which now
> > enforce limits on uncontrolled cgroups (memory.max =3D=3D max) ?
> > Or it will simply end up with the system-wide OOM killer ?
>
> I meant to rely on use the exisiting mem_cgroup_charge_skmem(), i.e.
> there'd be always memory.max < max (ensured by the configuring agent).
> But you're right the OOM _may_ be global if the limit is too loose.
>
> Actually, as I think about it, another configuration option would be to
> reorganize the memcg tree and put all non-isolated memcgs under one
> ancestor and set its memory.max limit (so that it's shared among them
> like the global limit).

Interesting.  Is it still possible if other controllers are configured
differently and form a hierarchy ?  It sounds cgroup-v1-ish.

Or preparing an independent fake memcg for non-isolated socket
and tying it to sk->sk_memcg could be an option ?

The drawback of the option is that socket is not charged to each
memcg and we cannot monitor the usage via memory.stat:sock
and make it a bit difficult to configure memory.max based on it.

Another idea that I have is get rid of the knob and only allow
decoupling memcg from TCP mem accounting only for controlled
cgroup.

This makes it possible to configure memcg by memory.max only
but does not add any change for uncontrolled cgroup from the
current situation.

---8<---
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 85decc4319f9..6d7084a32b12 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5102,7 +5102,8 @@ static void mem_cgroup_sk_set(struct sock *sk,
const struct mem_cgroup *memcg)
 {
        unsigned long val =3D (unsigned long)memcg;

-       val |=3D READ_ONCE(memcg->socket_isolated);
+       if (memcg->memory.max !=3D PAGE_COUNTER_MAX)
+               val |=3D MEMCG_SOCK_ISOLATED;

        sk->sk_memcg =3D (struct mem_cgroup *)val;
 }
---8<---

