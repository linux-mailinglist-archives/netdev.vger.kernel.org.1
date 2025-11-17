Return-Path: <netdev+bounces-239051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C7C62FE0
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C109F3AD905
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3153164DF;
	Mon, 17 Nov 2025 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmDlOwFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E130E84D
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369690; cv=none; b=sXU5fvJsgshalmkb6FqgqwewU0EfScjqx/qPdi3xeAcsSXbftCPcRPnsVVf7TVngAr+31Zc+Xk/RNaGoIb5HulEqNnSNsEkTyI3mHhlVuhucDJgxmA1Ejg+Kv5ZWGAhDdoZj7iIE7MN/UMrpG8FNz9UIC0GywVJOw7XIE0lJ/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369690; c=relaxed/simple;
	bh=S9skhitPqR1K90Ta/FOI+xvdgP7Uf7ls4Pz5r89g6QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9+RwKjrNjKgS8/I9gVHQ1Am5FU66wfdyOqgDw8u3r2xxAC7Ngpy7c58C/5PISxq+53o/8tw2KC+n3G16JGE5UGah1+LZKj4Km4QtrVmoFIgZcyixpqUATBj7wz8Er9sNxGLsNPOQojqsEMOoe1H7J+PGLnEPjC7ELekgnVACvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmDlOwFf; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-43470d98f77so17221385ab.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 00:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763369687; x=1763974487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9skhitPqR1K90Ta/FOI+xvdgP7Uf7ls4Pz5r89g6QM=;
        b=EmDlOwFf+gBXfTvN5ZUHCohBPRrtqd6pEAV9ReE2+KG2Dn4BNFPaNASWLN2yIPqP1X
         RZTdCH7U+LA/QGlCuUQ3wMB6PIIgW+EDDGQvNFYGYPHwBnxNr4z37td0CXy8BfVmZVUa
         qh26SzGm/lXVwxx0PWiaNqTPXDdxmhFDHUFjKpAjgbVnK6V2MQGqJjnHilAQOTrg4bNy
         YoOGgSZlhhMCMB4weTlj1h9J99nnvfSjDGgUed1PnxepEns3L618sCnkWqn4N6ArayiZ
         7j+yiV9XUBx8My27TWVtpQusID6oC/bVOB0n1EoJssdOo7yIDjDD3eCZcECAiPyLrE5q
         PHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763369687; x=1763974487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9skhitPqR1K90Ta/FOI+xvdgP7Uf7ls4Pz5r89g6QM=;
        b=HvEsn0JDGvsdUWRrb30G17UpMrhxNKCbr0cqnLGwCBrrYk5rfNJKUb5h5L5bQjxmmN
         PtJja/znYjW6/krbWKX7S4mpQ80QQuYTa4PtZl1oKRSX9d4OUnxAma/vomEbgJqo47LZ
         7xosPzH8AC+mR0wNtlt0iHE8r6NDu7Odsi9DwnAu+Xu+zmm9c/YD+3bEIhBN9ZPzi6TR
         ajSNVMSNyJyMXmUd59hv/km81vhH7rvZZ9g+Zs6YYesoaOW+YDmj/UaOQOCxU8Ss0s/F
         fM26SBdmvib/boV0kXD3tXhsXksqiHrHyBSniuinabFHXWqboUgHF3zt99kJxEbUqKds
         UdfA==
X-Forwarded-Encrypted: i=1; AJvYcCV1rZaffEhSiZ1lz/xpyAPKEOCfowcYqhiLG2DE76G6C4zKhsw5Jz0foDRppivDL4+iSgsRCo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTotI/a/8QeH2RFge85tDYwr76Asr7xlzB+t7PbesIqj8Np7w
	UI+EMa7QLI4hIgszFu2VC9iQJMQJfgwaz6RJnTZET/HK/5uMYJBws3GJoqOxnLoxTB93iIRCqqz
	NW81bj3j7FQ9ew/gh9h/RU8vC78l2ZdI=
X-Gm-Gg: ASbGncvcVDdyplyVRS3VtjaQ7TUl5SN/iA3G3gjBnqcvNwLx+XqlbpoCmRlgzkXVhqY
	gA9JCJbTFfa6nJtBzMs1mtK86FF6VitpQeIJW7Bqg2E6F3v0DpGyta2xzJbXjJApGxrOfHsmfSz
	v4yrowZvmJ/WwDm/yO8Ufm9KRF+iwK//i02Sq0IGbfDuY2R7evkQAD41hA4VsOckiGWiYwoXhHA
	UZbvPDzEBkR9P9bjqSulI6U/Lba3WxOnmY6aTdpTub3IJZWXi7I4/izErXYqShblxBUNfY=
X-Google-Smtp-Source: AGHT+IHz9NvlpLoLcWPMBiQI6RyPTekx4psmH9imhcaxFkFLILMONjdf7tAbNcGCdhCd+/zMrWjafg02z5NEh/NL7Sg=
X-Received: by 2002:a05:6e02:dd2:b0:434:96ea:ff57 with SMTP id
 e9e14a558f8ab-43496eb00f8mr82788195ab.40.1763369686831; Mon, 17 Nov 2025
 00:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com> <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
In-Reply-To: <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Nov 2025 16:54:09 +0800
X-Gm-Features: AWmQ_blBLihwhOwO58YvnNFCJUVN-78Z2XLaIpKDibIb_3-Tat281M2zSTbexog
Message-ID: <CAL+tcoDaB+ghuLZyGgcjubqobKuh0Qsfr5eKYdrOzEnCq9nCUQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:41=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb=
()
> > > with alien skbs").
> > >
> > > Now the per-cpu napi_skb_cache is populated from TX completion path,
> > > we can make use of this cache, especially for cpus not used
> > > from a driver NAPI poll (primary user of napi_cache).
> > >
> > > We can use the napi_skb_cache only if current context is not from har=
d irq.
> > >
> > > With this patch, I consistently reach 130 Mpps on my UDP tx stress te=
st
> > > and reduce SLUB spinlock contention to smaller values.
> > >
> > > Note there is still some SLUB contention for skb->head allocations.
> > >
> > > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > > on the platform taxonomy.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > Thanks for working on this. Previously I was thinking about this as
> > well since it affects the hot path for xsk (please see
> > __xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()). But I
> > wasn't aware of the benefits between disabling irq and allocating
> > memory. AFAIK, I once removed an enabling/disabling irq pair and saw a
> > minor improvement as this commit[1] says. Would you share your
> > invaluable experience with us in this case?
> >
> > In the meantime, I will do more rounds of experiments to see how they p=
erform.
>
> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> Done! I managed to see an improvement. The pps number goes from
> 1,458,644 to 1,647,235 by running [2].
>
> But sadly the news is that the previous commit [3] leads to a huge
> decrease in af_xdp from 1,980,000 to 1,458,644. With commit [3]
> applied, I observed and found xdpsock always allocated the skb on cpu
> 0 but the napi poll triggered skb_attempt_defer_free() on another
> call[4], which affected the final results.

Typo: on another cpu.

