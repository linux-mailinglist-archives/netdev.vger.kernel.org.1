Return-Path: <netdev+bounces-242285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8FC8E562
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F6AB34CC85
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36421A459;
	Thu, 27 Nov 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHGnda0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F961EB9FA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247823; cv=none; b=dngNm0mmL/ud/Nr8y3PugPQoQOnxXEwshCnlfL8CNPvumN75ME4mzblwXKU5y+PNYAs8GhKoxXEt/fYeLN8tcGbi79XO2iETzaE8tZ1VcxMlMu5fQofe7cXQ30QnccLwTYUrYiGnGOfX6DsnlQQgCjBGMijUtHVaOSjRNA6zIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247823; c=relaxed/simple;
	bh=qEhjYGJekn2sHM36iIdgoMW8GMxqSpDIsz+HWExog4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doAS5phLLyG5nRuzKyfSXkjJ188sZqBJ6d13UkWD7Zvhy8aqA8yjOotbLcK7/teHZTjfN7wXvstcWHaIvFPzjz0H868cel+xwI16cnyTpOMaO6pDPEiTRLX23RVZ2/DV8l09r3sUYm9J1/N65nQLF3xX8oMR2ScXwMFkFgLBjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHGnda0D; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-43380a6fe8cso4603445ab.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764247821; x=1764852621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdUBlaXRTmekXytUhwE5mIKdn4E13yB0O8ecwFhJb8E=;
        b=OHGnda0DfznBsOg15rVu8Dn3WLs0rTX5gFu2vJyoKU4dWz0hDKZr9Tmj+zeZg0mv6Y
         Ig9WSOEJEZ5dcNuL5jd92mOvX2SX9dlitXgh2PyzCnIqFg7ka36kC8IRzkDnxKc+abM9
         SuaTzAkAf1XGJNXeoC8u4VtHo52udkfHdUW5uaWr5L4hwP0wmU2qR1HRKKlNNPmpP+en
         ukcm/wfOd/mDq7zJ0exW/YBZozLToqUamPtHZK3hRTy1mDxgCesZVcS9rT+oyNdDxCXJ
         jVJhljwYK0fOul5SzVUjithGCX60fyl8n4TFuYCn8Z1BOazeZykSQiZLcHI91LqOw2zN
         vQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764247821; x=1764852621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdUBlaXRTmekXytUhwE5mIKdn4E13yB0O8ecwFhJb8E=;
        b=PJzoqTFhKip9ecu7vQY/hi0VzHDpLWjhn89jbAWn7cUKOkUFzZ7gs5/fdlk04rtus1
         nX0BHKjPkfkBTO9yG/uyOgNMhhr35ztJ4yMXZKGy1AN9UuOMlcs8TeL/7VBrTF95MZU+
         oQn2oCMSwMKahGCvZVgb1hjhsFyYieXQEa4UYK9d0lZmXfNzW0Ciru1nlVVges08c2On
         YHfLQ5yCFB9GwgxkQe3wnVpb33L2dC6wkSMromTU1uVc5IcZ7LlL5hUEvzPKPC3SI442
         4wxIpHPizX/RVNVN+nhZYrVEJ5v5LuCY4SqpTatQH7hJKo0wF/fx9f4hFtyB5J+5sGhv
         Rx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaQE9jl+GyVKSdeOI37SXUM3x8tG2W6DHu7CB8Cow6yrMwdckhJIzyqZjfC6HC3MO6TUXQB6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrv4z0x/iXmWCHl7Af2Dg8x5OTQNxJ6pw5Pd7i/nps7l5PMwBj
	r985gQn8MXSs7AocEUNP9DNWcdp2DS8u7yzqywbzOvYX9hHjl90nH8iwPEyyUldcyD0EnzU+xPf
	Oxu4MzGr9KjhuLwlzPrR5K0xwHPw4xjc=
X-Gm-Gg: ASbGncsjn3jwFNkVpCrmn2J4Fm5ORUaCqCwaYOS99gfKOB32uh1PCQ6HyWZbO1fM5tU
	ZlqXED4zzcuxTitkVXFHxfyNyZSKo5OGxIxwhgLneWUf/Yi8YyfX9sT2x6MRi+MoURHdT7TBluV
	k+Ik61LG3nEPSvthWxWzI1c7eeTQf2mqsK0aMIjNM1MjRSGtDzqojPD49XQWbxIvOcXcJlL513L
	QTAZ94yiQZX05li0UjWbEIOsot6OkTsZZ0yxj2+R9nNVOjfTCKEpPK7FjWoejbZWoPf1Q==
X-Google-Smtp-Source: AGHT+IFdUv9sOTmCT5IY7wY2U8Dv0pRh8vpsqqPTgWWjsqw02EA1W2e4fi5EcaDPbnAhskBenOejzupDTFu/GQBPybM=
X-Received: by 2002:a05:6e02:1a06:b0:433:7f13:3a8c with SMTP id
 e9e14a558f8ab-435b8c1224amr206960455ab.16.1764247821115; Thu, 27 Nov 2025
 04:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125115754.46793-1-kerneljasonxing@gmail.com> <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com>
In-Reply-To: <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 27 Nov 2025 20:49:45 +0800
X-Gm-Features: AWmQ_blBZXldg_fDFhGmx27J8EnktngNxeOQdAkEJSajcbi6Q1vGsBad76x5bkg
Message-ID: <CAL+tcoDdntkJ8SFaqjPvkJoCDwiitqsCNeFUq7CYa_fajPQL4A@mail.gmail.com>
Subject: Re: [PATCH net-next v3] xsk: skip validating skb list in xmit path
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 8:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/25/25 12:57 PM, Jason Xing wrote:
> > This patch also removes total ~4% consumption which can be observed
> > by perf:
> > |--2.97%--validate_xmit_skb
> > |          |
> > |           --1.76%--netif_skb_features
> > |                     |
> > |                      --0.65%--skb_network_protocol
> > |
> > |--1.06%--validate_xmit_xfrm
> >
> > The above result has been verfied on different NICs, like I40E. I
> > managed to see the number is going up by 4%.
>
> I must admit this delta is surprising, and does not fit my experience in
> slightly different scenarios with the plain UDP TX path.

My take is that when the path is extremely hot, even the mathematics
calculation could cause unexpected overhead. You can see the pps is
now over 2,000,000. The reason why I say this is because I've done a
few similar tests to verify this thought.

>
> > [1] - analysis of the validate_xmit_skb()
> > 1. validate_xmit_unreadable_skb()
> >    xsk doesn't initialize skb->unreadable, so the function will not fre=
e
> >    the skb.
> > 2. validate_xmit_vlan()
> >    xsk also doesn't initialize skb->vlan_all.
> > 3. sk_validate_xmit_skb()
> >    skb from xsk_build_skb() doesn't have either sk_validate_xmit_skb or
> >    sk_state, so the skb will not be validated.
> > 4. netif_needs_gso()
> >    af_xdp doesn't support gso/tso.
> > 5. skb_needs_linearize() && __skb_linearize()
> >    skb doesn't have frag_list as always, so skb_has_frag_list() returns
> >    false. In copy mode, skb can put more data in the frags[] that can b=
e
> >    found in xsk_build_skb_zerocopy().
>
> I'm not sure  parse this last sentence correctly, could you please
> re-phrase?
>
> I read it as as the xsk xmit path could build skb with nr_frags > 0.
> That in turn will need validation from
> validate_xmit_skb()/skb_needs_linearize() depending on the egress device
> (lack of NETIF_F_SG), regardless of any other offload required.

There are two paths where the allocation of frags happen:
1) xsk_build_skb() -> xsk_build_skb_zerocopy() -> skb_fill_page_desc()
-> shinfo->frags[i]
2) xsk_build_skb() -> skb_add_rx_frag() -> ... -> shinfo->frags[i]

Neither of them touch skb->frag_list, which means frag_list is NULL.
IIUC, there is no place where frag_list is used (which actually I
tested). we can see skb_needs_linearize() needs to check
skb_has_frag_list() first, so it will not proceed after seeing it
return false.

Does it make sense to you, I wonder?

Thanks,
Jason

