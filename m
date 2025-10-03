Return-Path: <netdev+bounces-227804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D0ABB7BDB
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8FD3AF74C
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D462DA76B;
	Fri,  3 Oct 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuIjM07x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7023AB8B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512565; cv=none; b=MtJRdu7422yM2qLyXdE2hl01S9+BUq0US+mk4GbxuDvtpgP1iRk5/aasra05capUIDyHpSSmlWdFn6aAoVBS3WJ1AWKQ5B5mebmyvJAGoUS1ELWpUnBjRuTIVO7g/qaaJfLzeKKUf4SCICO2XvHXsw5GhbU7hS8IQetPbhLyaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512565; c=relaxed/simple;
	bh=1Z1eZgXUHbUhnt6ifRLgYY1bBpQ7uOGH6Pqiebn6sXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkMB93tW3fN5/N8G8sGbsX9eHQaoOKhk87NgQpIsg/ftYfUC77aoB061vibf0KOsT01iMW1PUJQdGkNJe8RnIu2vAMiI9gRm5qsZXMlBpi+1pEH2mJAwSoEw9jhhoFDWTuV+i5DFgk75ER4IOVKjtX1pBnjY6m/J4zO1OGCJgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuIjM07x; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so28143475e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512562; x=1760117362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLx0sPfJY19ZneLVq1waLS70fIlfMNWcd5huW0a4ZEY=;
        b=QuIjM07xjJTmfIrnQR3EvK2scLSxqyNlBoHFsG9ROYsXOWJPdejEubRTYkiHQ7NEXd
         W+lIlRo8t6S+CNiU0osJ19hvsilUFjvbDcr5utnc2YbGMi3FHi0uQoel3s1q4sjdRSs5
         eLgI3p62lMP316xqNE5v54EMmNsmyJc6wrXS/2T0++F4LCdE6/MEwF4aeXt3Y9Q7Gd8/
         dlY7m8xrq2JWT+ExBD38YLx7kEcX8QWHnvHSio6iBlOamAsZONZqiJoE+jZZAPPup36D
         vkKGbMvplfBieyERTfi6y9wYK6o0AJkmb8Ami78AXI0u5nILJ+0UU8kFYjBCJFY/8qpT
         Ardw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512562; x=1760117362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLx0sPfJY19ZneLVq1waLS70fIlfMNWcd5huW0a4ZEY=;
        b=ZGbt0gazuKxnyoNQWSbzllWC37xx9kLa8g3SkjALBWOniP4jq125oBC1nmvE1d0uqY
         riBxBO3GzPw4CvJ8WiCjs+cH+CJ1r8HPt4WTpElGkz2y+zC7SZPkdz2JurZV6rH4Q/d9
         n/nQgiAPUEvnmSB14b6OqDs9LO1HYTWSCP4sNR4ptHfks8o5H77PmhiIulhbGMOTQG7g
         /mrfe+p+VkQcyh0QsGON02+dZQY2y40tddjj1BooBHVhZva4+659GrH3PjfqbsP9Ulbi
         fUCm0CgpCSjSWrolyijR1VFM+ehQivtagSYSY7AJz9V1TE5FGXYGPS/9tu+HbiqyFXJK
         AzFg==
X-Forwarded-Encrypted: i=1; AJvYcCWqAsKgS9J82zPZvpYm4SLL4Y+kUcEl3x6wy82b+6z9tw6hIqEJEIjVvrwHgmklqVm2xOyaB+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6L82aqRTyw52v9xIC0G7X4uliVKd8MFhsdiBHlPzXqQXfFku
	z8IrOxbWrHr9cxOP1mDS92ZxbPKL0IYOuYc+P5XNdj89Je3Nu0Jik2P6WLnOIGN29w0HLj/FZVk
	LtBcHZoe5/VwxdEGpLbDRjzTSkkrTR8E=
X-Gm-Gg: ASbGnctOXZWDkMvqazlcqAQnFnQbavi95X2F35vr2nEt85KDb+w54n2jhYuqwwrUPNo
	7R/DvYefm8RLlkDzxZpyDgAPJ4gVWhy5o2IE1HB22Bm1K1hf/AcqSTBoGTJSRwcyZfb5fXIhJLR
	axttTTvRmEldfk1MNaaM1Hp8YvxEdxHYlIeuUj/zU5Xq2mW6rHUKZOmJS9zU7axdnWq1ghY8V1Z
	VOrLiJnprW7DMPYOECEzSAfTgVEroL9ysTjXeZTV4DmvbyVX0rCTwN9Kg==
X-Google-Smtp-Source: AGHT+IFvUiOcacXwaHUMPjIbZAC1OpVWo3koSYKr+TsLcvQurc+EbgJSVBHYh7uNlChXhPHr/kAaaE2ILBWf0uEHlSQ=
X-Received: by 2002:a05:600c:8b6e:b0:46e:4499:ba30 with SMTP id
 5b1f17b1804b1-46e71153ad0mr27796655e9.30.1759512561771; Fri, 03 Oct 2025
 10:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com> <20251003140243.2534865-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20251003140243.2534865-2-maciej.fijalkowski@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Oct 2025 10:29:08 -0700
X-Gm-Features: AS18NWAYIb2kWQ3CTUdycIF8K0dYH7l-Aatdyqmy8xN3LnrgUgTCfZNHar8kh2k
Message-ID: <CAADnVQLGocfOT224=9_nJZ6093QDh1M_EDLQ3cNVQZKEDnjwog@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:03=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> which do not have its XDP memory model registered. There is a case when
> XDP program calls bpf_xdp_adjust_tail() BPF helper that releases
> underlying memory. This happens when it consumes enough amount of bytes
> and when XDP buffer has fragments. For this action the memory model
> knowledge passed to XDP program is crucial so that core can call
> suitable function for freeing/recycling the page.
>
> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> of mem model registration. The problem we're fixing here is when kernel
> copied the skb to new buffer backed by system's page_pool and XDP buffer
> is built around it. Then when bpf_xdp_adjust_tail() calls
> __xdp_return(), it acts incorrectly due to mem type not being set to
> MEM_TYPE_PAGE_POOL and causes a page leak.
>
> For this purpose introduce a small helper, xdp_update_mem_type(), that
> could be used on other callsites such as veth which are open to this
> problem as well. Here we call it right before executing XDP program in
> generic XDP hook.
>
> This problem was triggered by syzbot as well as AF_XDP test suite which
> is about to be integrated to BPF CI.
>
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@g=
oogle.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Co-developed-by: Octavian Purdila <tavip@google.com>
> Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, test=
ing, initiating a fix
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit=
 msg and proposed more robust fix
> ---
>  include/net/xdp.h | 7 +++++++
>  net/core/dev.c    | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index f288c348a6c1..5568e41cc191 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -336,6 +336,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 n=
r_frags,
>         skb->pfmemalloc |=3D pfmemalloc;
>  }
>
> +static inline void
> +xdp_update_mem_type(struct xdp_buff *xdp)
> +{
> +       xdp->rxq->mem.type =3D page_pool_page_is_pp(virt_to_page(xdp->dat=
a)) ?
> +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> +}

AI says that it's racy and I think it's onto something.
See
https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/51892959=
919
and
https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/51892959=
937

click on 'Check review-inline.txt'

