Return-Path: <netdev+bounces-273787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJY8ImpWzGn/SQYAu9opvQ
	(envelope-from <netdev+bounces-273787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E1372A9E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134D33015CBA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCA466B6D;
	Tue, 31 Mar 2026 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sM9WTPwR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893693A962E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999129; cv=pass; b=Tj25TrXRciNHIakY2JyfHmLMvYH166ksJC1KtMQlzF1tc31ahlVshay2XKZrrytvd53Nyfwuf902Ogv0uMprvyznOpDF0zLiysx543RcVKbSXC3sWHeicFiU2OrK+iFu5YXp4uL6Pq0wPv+c2NM7T3wi3lvBoezrVotXevtPImY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999129; c=relaxed/simple;
	bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNdyS6O800//+q3uTgWsnCKkxT+Y9nCjwuK7g3xjQ6A5kq5dypyvjgFjXjpUQvrzrO4fqZLv0MkhsfmggNhNxpBGyCT5ap9hpxtif8x8yJFllbT2L/MAnLl8ZM6LHNaH2BDT5ru8u7lgh+7cDTut+V4gOamcNeiqLPt05kgzTAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sM9WTPwR; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1273349c56bso7941913c88.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774999128; cv=none;
        d=google.com; s=arc-20240605;
        b=WclZKVxcWUKGhV6IWhckExz2nplK45UhkB05L0gFZvebrIcRsmm4kxnRkmjHeoPvU3
         Wj9L/AS9mAIjf/LUQJIouhcgV2yWGfm6ZB6iqPECSlVsAVtrMWY1X6bkOVo9+x0cpa4T
         PmJcoVsxinUb4WhBPuOT4TpGjJ8g5C1mzt6GLp1Sx9RsZUh59YIW6gtsgNht0dIX1uZ7
         KXtLe1q/GbWt9fmhBx/stkL93sFni5Hl1gW8zUvJlUWThiFSAmJ6A+iH00EahL3OjfzR
         ZYMicRQGPwQ9GwGOsRAnUPedMX6lztv5dnDaW7Oxo0gJQG70lzkVa3vMoeN4HvVI3noV
         /MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
        fh=uM8gmbkNUZ68wlKpcsXivjVirCiVhufyXXHOC/W0p5Q=;
        b=hqf1CB0tU0dnX7TkupUeQHqp3t9zDsArL8yjjTFCz4kNWwE/YCicLfOT/mXOHdwYgL
         L3AlTzutwQFF2Ezd3n4K1F1FeFfjl4tC5hqnPKYQNvqurqI94wR7MpEP1vfQ+VsU396E
         sHbYPCA4wHpBBHI6oVqBUJiHGU5NayF8gAAHk7aCGFPeecKLWe/WYzmOSH3qnl/ZebKG
         tAOs0hiXhGMxA/lxoTt+97mNTdGSs5KrIibGEGLPvYqcogGhNrjDR88db5qLAq5LNxCD
         xZNnxfg9aV4VD9GhukH1pehE0Oj+H/62MvVfxfaZGup01NQvxMWEseDs8xobUI5lDGkl
         tO0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774999128; x=1775603928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
        b=sM9WTPwR8ZW59p85JIBE/PXoq8GU2RQvqR9xuKr2+K/a+r9tqFu9l50/WINrVwQpms
         7z1+esNp99YQzU7O5xr2p9XwGv6cWrjfM17zR1Hk+uCmJlCftdqm/qDCXU+MMElxxLAi
         BJ2XrR7s/2MjcFCInuxZ2hWdtpmH8KaggSL/b+/QL91rWBb2bSBNmGqEm6gtvomfDd4w
         7fWPWBJjSHtHoNDvAwocY0UMw/sNH1Xf7kUxa/ymYRV1mNqgPtt1Fni9akWwE7Pre3Qp
         HjhO37lsUiRCazywKbVFyZU8GavRyUEJ2BLCGya/syjtEJcChX2Kuw9DjGItPhzpcGh3
         QfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774999128; x=1775603928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
        b=TSm1mXA1nXYaYgEptDJyVL/nKCe3/1lPw34+Md/lKAlq6TYUkcxjJ8Unq2tMl89KRF
         tXh2t60S1Eef3cAHyPS4S+6gBVHr0oh5VjGf1dhtmPPux84JxzVVctQo0SUkEsbQ46+G
         gc4K2127jPcHVer+npHUzIb+Yo5/4YFIDoJwUUjErbte8zubEq9P6KjQvFjpPv3IYu6h
         wSyOHZV9ga3+p1BzIGDfJpxUxOLyNcT0GwNCQJMZD+FH5Q3+ikdxJi2bLAsxtUPZOjuY
         IYCEgNC85k6aH+VOQ0lOsGf1hH3nQdfGd7PjjFg6xMzXtdwrOdtkWzmO/Og5I/RJNOsE
         BPaw==
X-Forwarded-Encrypted: i=1; AJvYcCXlGA6G+MUs91IT04bXwwxtFVAmhaviLWaimBGjv5HeWyAPvCS76UeTdx2W+hhrEf6T4mb/tw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZadX+TLb4x8SpJSwdO1JhCPDQb6BL7l+yYHJarGLAfVmsCQ1O
	M4CVt77jj8HeQ6YeYSZlvxAE8sB/mvmiSDcYyFD0u+o4l+hyszJToizqa1ORnAvEYlU3Pfdx+E1
	QcOIumwzpK+LuGJnhvPKwRQSQLHyu3/PxkEOOiajY
X-Gm-Gg: ATEYQzxd3J9t4YQlzwehCKXFtJesgst5IPuQxOv/xuwLHMJJOXc2dQWgkzL1yDnvO5c
	dlrmsEMbs8LXKFkd37RvLw26mrzS8/5bSYaigvKH0bQptLLN/7ClgQ11l4IMPApiDCITS2fM+AB
	Smu1bqecdS7PHPf2Xptcvnvx5+OHimIBQjceutcWXYKkcdKVSWyRykHrDM6KzGJZUtmDFPoi1ld
	f8k+VruULp8eoTcRBfbVs7Ibrgdfcq7jEzjK6Yl68aneW7w2o/yQO9zVN95Plvzll0THIYGhomB
	Nq85zIqm18A0kJokY3NGrePTZbp5N69UCJvohlxjjphfx/iT37Sq0XVn6L3NDSBFc+03Aw==
X-Received: by 2002:a05:7022:b8c:b0:12a:6fb7:8801 with SMTP id
 a92af1059eb24-12be643827bmr836648c88.14.1774999126972; Tue, 31 Mar 2026
 16:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
 <2192e9ef-894f-4826-b296-4f90e973a31b@163.com> <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
 <b21fac4e-891b-481c-9734-e95290e49097@linux.dev> <fa818820-c0c9-48dc-8ebc-661cb3349935@rbox.co>
 <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev> <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
 <CAAVpQUAtF29CPDAdEUchYOP=oy8D2-B3GH3fWs2pwTmnYoTu=w@mail.gmail.com> <48bad987-a130-4fb0-b4de-e39deac80ab9@rbox.co>
In-Reply-To: <48bad987-a130-4fb0-b4de-e39deac80ab9@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 31 Mar 2026 16:18:36 -0700
X-Gm-Features: AQROBzBDc0n1-_f0-_wUbzS_nTN6WPvIo3JBShn86M-8Oos7kh40q0Zqbff_Ie0
Message-ID: <CAAVpQUAHijOMext28Gi10dSLuMzGYh+jK61Ujn+fZ-wvcODR2A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <mrpre@163.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273787-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[linux.dev,163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: D83E1372A9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 3:44=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 3/31/26 01:27, Kuniyuki Iwashima wrote:
> > On Mon, Mar 30, 2026 at 4:04=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wr=
ote:
> >> On 3/26/26 07:26, Martin KaFai Lau wrote:
> >>> On 3/15/26 4:58 PM, Michal Luczaj wrote:
> >>>>> Beside, from looking at the may_update_sockmap(), I don't know if i=
t is
> >>>>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
> >>>>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when lo=
oking
> >>>>> at unix_dgram_sendmsg() =3D> sk_filter(). It was not the original u=
se case
> >>>>> when the bpf_map_update_elem(sockmap) support was added iirc.
> >>>>
> >>>> What about a situation when unix_sk is stored in a sockmap, then tc =
prog
> >>>> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure i=
t's
> >>>> useful, but seems doable.
> >>>
> >>> [ Sorry for the late reply ]
> >>>
> >>> It is a bummer that the bpf_map_update_elem(unix_sk) path is possible
> >>> from tc :(
> >>>
> >>> Then unix_state_lock() in its current form cannot be safely acquired =
in
> >>> sock_map_update_elem(). It is currently a spin_lock() instead of
> >>> spin_lock_bh().
> >>
> >> Is there a specific deadlock you have in your mind?
> >
> > lockdep would complain if we used the same lock from
> > different contexts.
> >
> > e.g.)
> > Process context holding unix_state_lock() with the normal spin_lock()
> > -> BH interrupt
> > -> tc prog trying to hold the same lock with spin_lock(). (_bh())
> > -> deadlock
>
> OK, I get it, thanks.
>
> So here's one more idea: the null-ptr-deref issue is connect() racing
> against sock_map_update_elem_*SYS*() coming from user-space, not the
> can-be-called-from-BH sock_map_update_elem() variant. So can't we assume
> that for any sock_map_update_elem(unix_sk) invoked by a tc prog, unix_sk
> will always be "stable", i.e. in a state that cannot lead to that
> null-ptr-deref?
>
> IOW, if for a tc prog the only way to get hold of unix_sk is look it up i=
n
> a sockmap, then (by the fact that unix_sk _is_ in the sockmap) unix_sk wi=
ll
> be already safe to use by sock_map_update_elem() without taking the af_un=
ix
> state lock.
>
> Long story short: take the unix state lock in sock_map_update_elem_sys(),
> don't bother in sock_map_update_elem()?

but it will prevents bpf iter from taking unix_state_lock().

I don't see a good reason to introduce a new locking rule by unnecessarily
wrapping the entire sockmap update with unix_state_lock() even though
the root bug can be avoided by a simple null check in a leaf function.


>
> >> ...
> >> And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) ne=
eds
> >> to take lock_sock() just as well? Would that require a special-casing
> >> (unix_state_lock()) for af_unix?
> >
> > Right, lock_sock() + unix_state_lock() + SOCK_DEAD check
> > should be best.
>
> OK, got it.
>

