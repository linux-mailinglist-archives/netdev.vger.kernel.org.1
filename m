Return-Path: <netdev+bounces-227537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FFABB2402
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 03:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB833AA5B1
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 01:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC321339A4;
	Thu,  2 Oct 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzyKZC74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0678F2B
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367741; cv=none; b=iDIPJueamSh4+XEJJ+Ngh4tsjjYLo9BQKKdGlyCgN/Q/SWwYJ5dyad7ND9QcW2MHyEuNC/JiX4Dxua6GRGbQmKkh0GgL7004Fx/YOYWBnhLj0b39qSmqALRe4xlWNv/vzb7AWCSZK2Wa7Y/cI1F0z7OhNLOh/QJa3HNQ4UtNmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367741; c=relaxed/simple;
	bh=JKhQbZsUBTEPWhMd10mVzzVtvORQk/05UaHxitUieA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkf8H4f8ReahsLDN1f3NzS/woqV8JALFVGfYNo66MlgpYOpzK+vpd2t+IShEF5A/O/ByZb/BwsmC/WNmefrRXXO+fEH44DOhBiVVukPhUFnJBeb7iNxoIyV/l5/fBf3adqPo+FDyo7j3v9lilJKxlZeMOSgNGmAXZ8gUJOFIUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzyKZC74; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4de66881569so234041cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 18:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759367738; x=1759972538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMgNT/1x8z1utdDYgKHKTeeRqtfkL3MvkmmESru+sa0=;
        b=WzyKZC74EWlgDUx04BzpmX/6VwrNLgVjGudZkL2FHEquctE24HFbRUsceMwBf+zyr9
         PgDakiSLT8xwmcJegVuSGICfitkuPRVnP6PxMHSggh3hCroaSrsKJmowkznRBgMEEb/e
         hpJu+y3dPpejLNVhR6qlSziE8lRx4L6icvamsUQ3emMVoMOeJMqfuf7hf2PfJV6m/Xvo
         bsfkTDYXcRhwcaKu9ZT9A6CLg4a7zTAZ4B/g7ZAJIq3Vk8yh5CGIPX8UAK1ws1Wl5XhO
         QItIYRrQyMK9Wy15ilSWKTPUmAcmi8L57yprmhpQAKhqZAr2l+ErvZCKlguvUYkFrxuE
         O1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759367738; x=1759972538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMgNT/1x8z1utdDYgKHKTeeRqtfkL3MvkmmESru+sa0=;
        b=UzkIU537D0rGTlF79qPnobrYxVqE6IpACV1w8+6xoJp3CT5Fsqrpn5LUn1AGKqmfHc
         oTF3RziywTN6yJThrTxK2Lml+SCZHwvjys/6A9KJqCQU8Xj2sEcsWnwUVp5ZDfvgEU1r
         13LVPbXZzXYnCcRJzqgT6pza1MpvAwBQdiBwOtl9n1O12TkmoIOpbkPNCNM3Ryx2G1us
         01Ja1oqy5zYbCa0anGiKNx/HpbjKI8JyUpMUeQtSCksemFs+lv3cslfbASdGVp2yDg3i
         u/7Q8YsWGV22qNI8W36tnmH9mnJBg/U96AXU7n97cqGmtj/siBdR/dzowGaVSJRqBDtI
         2/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWFJ45I0fipKQr/an2cqxpJQXi4VIMat95tBW6Dm+uicsHuGN5UD8CA5Y8GEgDaSomdxG994hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya1xP4A3FqhUI83mfT0roXiaa2ndr+oBLPXViIAYg/sR9wcI+0
	VC2i2NyzqWQ9vk+TaMiNKKLWILudAPCnsXaoasuU/eQy8usUohrjkGbHBTLpJsAg8tOZcBpgQqc
	Yw/RV9wYibttbVAwbbOKwhLsz5XmnovgxPpDShC8t
X-Gm-Gg: ASbGnctvpvjhS5Upw06d1ulYexrsSKdaAoskgmDZqqf//fKDNTIgiSOjBSZuxUWSAeQ
	8mR1WKG4Ti9UqUID1t9QUFVZMuGtU6XGIBY5z4UnzI39YaAetMc6Wjp/8bfypvje6VSZYW4lMXG
	Gp2VsRKQviF6WROuHvrrrymNdp6KPYl0PcErdkZ8eMnZqwXdKLogWWMwHw0n/0OAJWti+LT8msT
	LluCspQOxJej6Wk16yPRvpbMLC8G7qZwOdtict34QDA3iO60kNsLHITWn2jY8GshrR79Rv0iZz0
	iP5VdQ==
X-Google-Smtp-Source: AGHT+IGdMl6CIKTN4pE90JFzZFLVGowsdHBBDVGm9atrf3WOR5kwNtlwrFbr1CnYAv34CMLs1bYPuu8RTpowcCBf+FQ=
X-Received: by 2002:ac8:584f:0:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4e56b1c1f1fmr2840781cf.10.1759367737081; Wed, 01 Oct 2025
 18:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001074704.2817028-1-tavip@google.com> <aN091c4VZRtZwZDZ@boxer>
 <20251001082737.23f5037f@kernel.org> <aN17pc5/ZBQednNi@boxer>
In-Reply-To: <aN17pc5/ZBQednNi@boxer>
From: Octavian Purdila <tavip@google.com>
Date: Wed, 1 Oct 2025 18:15:25 -0700
X-Gm-Features: AS18NWDy1XtaBZhsbQmwi36wcmA6oBe8mTFyPt8fP9YrWLHf1E1EALGgc3kwh8I
Message-ID: <CAGWr4cSMme5B-bMc+maKccoYxgVeVKaXk7Eh=SOM7jX3Du5Rkw@mail.gmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com, 
	aleksander.lobakin@intel.com, toke@redhat.com, lorenzo@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:06=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Oct 01, 2025 at 08:27:37AM -0700, Jakub Kicinski wrote:
> > On Wed, 1 Oct 2025 16:42:29 +0200 Maciej Fijalkowski wrote:
> > > Here we piggy back on sk_buff::pp_recycle setting as it implies under=
lying
> > > memory is backed by page pool.
> >
> > skb->pp_recycle means that if the pages of the skb came from a pp then
> > the skb is holding a pp reference not a full page reference on those
> > pages. It does not mean that all pages of an skb came from pp.
> > In practice it may be equivalent, especially here. But I'm slightly
> > worried that checking pp_recycle will lead to confusion..
>
> Mmm ok - maybe that's safer and straight-forward?
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 93a25d87b86b..7707a95ca8ed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5269,6 +5269,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, s=
truct xdp_buff *xdp,
>         orig_bcast =3D is_multicast_ether_addr_64bits(eth->h_dest);
>         orig_eth_type =3D eth->h_proto;
>
> +       xdp->rxq->mem.type =3D page_pool_page_is_pp(virt_to_page(xdp->dat=
a)) ?
> +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> +
>         act =3D bpf_prog_run_xdp(xdp_prog, xdp);
>
>         /* check if bpf_xdp_adjust_head was used */
>
> As you know we do not have that kind of granularity within xdp_buff where
> we could distinguish the memory provider per linear part and each frag...

LGTM, based on my limited understanding. I can also confirm the syz
repro no longer crashes with this patch.

