Return-Path: <netdev+bounces-268046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEFyL9Wyt2nUUQEAu9opvQ
	(envelope-from <netdev+bounces-268046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:35:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46988295B38
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EC053011040
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9363311C2F;
	Mon, 16 Mar 2026 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik15KYkc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCNxwZQx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37034EF1C
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646539; cv=pass; b=g4HU61BFSzoBjwU0Hd6E7pvOAsPXJOaQm6vlUyz9VAw6zQ284JeMNGazhLEKX3NqRi0yZRuNXPdKmnhWZB2N8QXl2kQ8+eruWYFaZCPrfLeDW3cwnfkjzzikKgC98oNi/GN2fhTkWU1GGy4AQroAwSRHWI8g4W7860iA1zGJ2NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646539; c=relaxed/simple;
	bh=lAhWFR3bWeLZMNXrZqumDODsT4ckBImkBWjf2qGHHVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjOeN3az4Tu2ZnJgdzbWol/QpTsUmVUIqxuWcxz+9/hR53o/Pw+jJLNSx38LZz25AQdCBMADjjSwxMSjuEwnJyiXHaEeoY46moFHd/1Ajdsvxpj++kjtzbV52CuQ9eWSZJDhc4X2nGU6IFRYa/jwjk6d3ezmOoQd3gWcrjCRbtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ik15KYkc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCNxwZQx; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773646537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ardp/fbfEqn64qjd6obkacuKJHkoPymrZiOmJjjTPnQ=;
	b=Ik15KYkcyiwHPBcKdKehU1SyBIIht/QTOFoIuhi0d3MfavXCoVkMeVqnGL5EoFAFwUoJoS
	jBooppr3HG15W808crBsJ3ysDMuWkAIJJDDm1dUIgyZmqpJ7GiXM+SmQPQfTgWiK11tyJ/
	qFrLp5YMAG3yplJS0j+QYw+VYkHBsYA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-0TTgKd2AOJ-tsNGnDJQL6w-1; Mon, 16 Mar 2026 03:35:36 -0400
X-MC-Unique: 0TTgKd2AOJ-tsNGnDJQL6w-1
X-Mimecast-MFC-AGG-ID: 0TTgKd2AOJ-tsNGnDJQL6w_1773646535
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aeaabedbc3so342082495ad.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 00:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773646535; cv=none;
        d=google.com; s=arc-20240605;
        b=NyFv6qRmCPBAUnkSCxVIF0FWAvCO+CKAk9z9LRsfg0BOjthKA89DKTSG+AgYQ0UbP5
         8LOS57eu1jv01IOXvywi8gkzBAuINa+9ROduuSAD7Qsbn6bG5YwL2Y5njIlNRgvVpkAM
         mL7iqy6gtWnzo8i+CSup9nZMf73gNOSMV0xIsyEjCgbvNfVo+C5pAoI/zTQDwl5gP0zB
         0BTQRCtGmWzskd/xKw3b3MmgiJRZFW99F3+sL43StDammnso7I71ddPse/qth4vtu/8U
         KUInBjEtJKa1Nd5KNstEfDGaggD9HVL6l6ux87Y2hFORyTgEuKpVBhdfB0GXw6ik/fVv
         liOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ardp/fbfEqn64qjd6obkacuKJHkoPymrZiOmJjjTPnQ=;
        fh=RXFzTzBUQ6qjq7mjbzxFf/8dITVvuh/DdHQlRCjgXP4=;
        b=MY3lLD0HrDrRvSw1QLfqET03Gp0GDYqVR7eW7zxmF7PchGSdMr3LnHjg5JsbnRkSKw
         O4N/HtBp6UKKh5BVfVduBagL80xfClMZaOpmJtEMy6dsYMWq5ygqGzcInlCcYG4P3xvy
         ch+d+gGG0eJ6u62dE4vZvAj+il2bUVVAWpiSl6kkslGQ+ebn4Gu3CwZgZsgWrPlLi9LJ
         dg8w8BUxZa091MXkp/8I/ouE30s868nXqW5Aw0Qj4LAv7hlgNCgveQC48LyCgcCtgu3o
         Nfgl+0BzNS6wKrynQ/2kd0NzUi0Mh/nQSEouh/mupCx1L32gfoGcweiRfCePiN14rdfP
         orIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773646535; x=1774251335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ardp/fbfEqn64qjd6obkacuKJHkoPymrZiOmJjjTPnQ=;
        b=QCNxwZQxDgwLfs6PDQpw34Ij/t/Dbjts/8qY21DwhQElbKdFvoUVtIf9rGdZx1tW7X
         SxKhrc4woZRaKeIou0eRgP+BwzC34mVH7aHz/SpqcK+gfpijB10Ja8pOVFh4/itQq0mb
         eGUfeN5Oiaq9URjmE9AfFk8I93ugORqMOOluV2WdAt5dMOK54YYNURhIx5f6Eb1gYqs1
         LOJp5560rKiduDqYS8S/kpqbeH3s68/q5L7E8VpRAXA8STUkEWlcwtwlxu5GZc9prqsX
         mOM0Qo4h1uiyrZS8lAcosTQtR3QSYQJj3Wo3JY2eBOYzYduGI1eIHlHv5IUQfZN6nGtN
         oClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646535; x=1774251335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ardp/fbfEqn64qjd6obkacuKJHkoPymrZiOmJjjTPnQ=;
        b=MFlODGsrRwJhQ/Y/0rJUQQtvyLNfYXjNb3ScnVwMBHSanKEioOKSIkLZWujXbSe+/C
         YKy7gk0P+LALBCV0LPe5ZlH25RHTL+lIulmSt7BdF7rw++w4R0MCzijZOgV32w3joAfu
         dp9mgjzJJJRzarkshl9ZSUquObMmRu9Njgspt1ebol4Lt+Bfz9KsUXJ3aihWV+l+Yz7s
         BkRgMxn6rggE3t5OMhwbWvXAzpSYYNWo8aP0wcaafO2tBHYxkBKdTkMxPGy+iq9415zn
         29cwPBs7ss9bXbKULkvDAlvDlpu+C6Kdy4wLxVd0AgoQScx7KiNWuE9JihXGjP+gb+wI
         qhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUpsNv18vNqMo8bEfQBwKItWDSHisqP2T2Ajj0EnvnqaBrgJ9XYLcD6P3ozdkvpEKrP058VSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahHwxYpH+nb6rq5x0Mbd+kN9uaoUjGM/ETfoNU/h/jsrl96nV
	24OKmHZAYDypg+DkY11fZmVH1HwdDrbgYk9gxi3N97n4kfyCszgnm6aHkG7SY+6+dn4GWMsBkxA
	dTv1csqNqC+a9SVmimtm5tTsjLPP2AGtuwyuPcMe+hXMdslyZJnRcIvDFhj+qQak2gC2uRcIBdH
	rHi65kY9o8IB8wejwlYpBg0h/BLAibooBE
X-Gm-Gg: ATEYQzz+dXpFafYQMJYuzxSvL8IcN9j5GU96mNdAEn62ype2alNwL82G7fm5qjfrY7M
	rXbCTurenemjNFPl7a05eHh/1Zs8P98Y1Ww561Cr1KHwoNiRddgLHa9AeQMKtEZo6mwCaqaWtv5
	yZlPQMlF+lB9xJ8wMySQSNsY7PbURYewtGjhHXFhKPRXD+jBhMqRynfGcZnEe4u/Ezz3YRdQwFD
	ZE=
X-Received: by 2002:a17:902:f650:b0:2b0:58a8:5fc4 with SMTP id d9443c01a7336-2b058a862b6mr23039085ad.50.1773646535007;
        Mon, 16 Mar 2026 00:35:35 -0700 (PDT)
X-Received: by 2002:a17:902:f650:b0:2b0:58a8:5fc4 with SMTP id
 d9443c01a7336-2b058a862b6mr23038825ad.50.1773646534592; Mon, 16 Mar 2026
 00:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310183107.2822016-1-vishs@meta.com> <CACGkMEt8WWbHRpD-e4aHBdwbK9QdvCcCX39xzK6FRrb263G+5w@mail.gmail.com>
 <130cf9d5-79fd-4d12-ae3e-3cafebde02ce@meta.com>
In-Reply-To: <130cf9d5-79fd-4d12-ae3e-3cafebde02ce@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Mar 2026 15:35:23 +0800
X-Gm-Features: AaiRm519WlL2o5GfvD8ccaY4YvNIamxuTuuvNhNKG3MAIpamtLVCsJ2D-ZyJFmI
Message-ID: <CACGkMEtBhTtzjxaUnN_3+gHUUq0v9C0f38OJ52HAz9WhoAnWrg@mail.gmail.com>
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268046-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 46988295B38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:51=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.c=
om> wrote:
>
>
>
> On 3/13/26 1:21 PM, Jason Wang wrote:
> >> -static void put_xdp_frags(struct xdp_buff *xdp)
> >> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *=
xdp)
> >>   {
> >>          struct skb_shared_info *shinfo;
> >>          struct page *xdp_page;
> >> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> >>                  shinfo =3D xdp_get_shared_info_from_buff(xdp);
> >>                  for (i =3D 0; i < shinfo->nr_frags; i++) {
> >>                          xdp_page =3D skb_frag_page(&shinfo->frags[i])=
;
> >> -                       put_page(xdp_page);
> >> +                       page_pool_put_page(rq->page_pool, xdp_page, -1=
, true);
> >>                  }
> >>          }
> >>   }
> >> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct ne=
t_device *dev,
> >>          if (page_off + *len + tailroom > PAGE_SIZE)
> >>                  return NULL;
> >>
> >> -       page =3D alloc_page(GFP_ATOMIC);
> >> +       page =3D page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
> >>          if (!page)
> >>                  return NULL;
> >>
> >> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct n=
et_device *dev,
> >>                  p =3D virt_to_head_page(buf);
> >>                  off =3D buf - page_address(p);
> >>
> >> +               if (rq->use_page_pool_dma)
> >> +                       page_pool_dma_sync_for_cpu(rq->page_pool, p,
> >> +                                                  off, buflen);
> >
> > Intresting, I think we need a patch for -stable to sync for cpu as
> > well (and probably the XDP_TX path).
>
> In the old code, I believed the sync was handled implicitly inside
> virtnet_rq_get_buf() -> virtnet_rq_unmap() before data was accessed.
> Could you point me at the specific path you're concerned about for
> -stable? I want to make sure I understand the issue correctly before
> sending a fix.

You're right; the code seems fine.

(Note that, when big_packets is true but small is used, we will go
virtqueue_get_buf(), so the unamp is done via deatch_buf().

>
> >
> >
> >> +
> >>                  if (check_mergeable_len(dev, ctx, buflen)) {
> >> -                       put_page(p);
> >> +                       page_pool_put_page(rq->page_pool, p, -1, true)=
;
> >>                          goto err_buf;
> >>                  }
>
> Sorry for missing that comment in the earlier email

No worries.

Thanks

>


