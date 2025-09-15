Return-Path: <netdev+bounces-223247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0BB587DE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9FB2A3C9B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5710A261B7F;
	Mon, 15 Sep 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3i98qmU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56972D47EB
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976655; cv=none; b=CDUk1iJSeO8ZtJwcTHCggVGpFeF+AOgKuC6lqA/HUs7ChrfIO6YnLVnLkOrzw3kuz0NDcNgZWeoJ55ckmsCU8upM3j3vWqkU4GtLCqIdIb/uLfPm7EgUTXtqY4utNojvMCCYm5xvc+r7DBZcwGHkyWmc0gK4jrlVVFDh9aSUPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976655; c=relaxed/simple;
	bh=YV+mX6ASnUXFzjjaCRaGr81DZRor0C7l5I6VEU94phk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUrKZS7ZNZ3CFqPHMaHm/WCw7z3zG/nD4QDqQ1Y960+pKjsdI03wxzRGrxuSyN4Z1UI3mVh8YfzqVBHisvD2ucnErqhTVsTq1zOC7MqHurdd8FZ1KO0YGPQNLcZhCT/PlISIsY8f0B/H9V7RM+OyzwDAev84lns/WmS/V6+MN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3i98qmU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2570bf605b1so46575195ad.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757976653; x=1758581453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGqayK5pIRNY5nc024a0H8Vjg5RMivqKS163iVXho8w=;
        b=q3i98qmUVxPk8XfiPw4gGzWOSA5R9TFFYumfEUZ8zQTT1NwC4e57bAnFIvm51bBefy
         AUf8pcNmGZN7Dkszt9rYFIXR35f1nfmZbu6eGqj/Z2B3PHeQyAxdOtKANKR5HOB0QkK/
         +6Zf4r2cvSPTrecRD6JxfH86C1GxKMVeEUfEJxHI8CqmQDynNVUXTW/Vyoc6unu0KUxN
         WOMzx97aDfUZC8EEitf663Xi9GV+uPAYzlq4nyJB/93D48r9Bf3VBDROIE+MoKrg0wd8
         AInOtJYNuShz2twDDngysqvt49vub6XAQMEiM3bsni8bCUkyDYI/YtOpPLwbTG2dOshV
         pZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976653; x=1758581453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGqayK5pIRNY5nc024a0H8Vjg5RMivqKS163iVXho8w=;
        b=Jc6xgL8JFb4hNGlOBsksAyK/9YXFUEaLLYvWnFy6GP4n+3l9STXz7NUGOj3YLpl08J
         hQeLrzSxrin1sXOGmgfyFIXj83Bgay9vxT4Uwggix+Copk0JIY6r0/uAyKOEe6oTZsL+
         4ddN8ULFtUSBQjmygt79cc/mhb67wR4uJqxU6fHBaiFPtlLKk88cMAHa0UDXmlS8eE63
         mcZrfcj2BvbB++NhrIvTJGGo/JlLj9LOMr4z0hFUXcSEY7YLchSQTzBo+5q36KwhF57o
         281c56yEq2PqB42NgUxigVmGVmBSzFb2KszHTRlPaGtOvmHBic67b8v1h+TzIDnnJ8kA
         ri/A==
X-Forwarded-Encrypted: i=1; AJvYcCUKPQwOOOfVuUjHaeyxCs0sH7IrEW2K2T7mS0X3TLMGoFhKZZyDyAGy/eBCwQ07+n6rXx5QgXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0p0WgYE069tbPyy3UuxmoWAkob/bvzbzbSvmWaXs/9l7FlumM
	mkFB5mWikC65SHyrGFRZsyUhOGIxhzWHOCJmtThZFKDzXOnXjXDyaUEnVHlN+UHQvpWJEQDwf+B
	h7N2YyCVoFLxwkU9+fZwpoO1d6zHasP1/uAWI98GU
X-Gm-Gg: ASbGncsZqMBDNxynOGLB3mX4w+8vUU1z8gvpcDNaK9y2Z3LIgeQQRlCNb9mVh0tyCGK
	VMhtJhxudD60Hfjxa1TfGxPGRYlXuttFnC9NiTAhkbquqDz4e/XZPbtEYh6A73MnTpjUoVvorg9
	ZMInTBZTm7XHkR0PiUA1Sp5lIDNZquUYmJIVyYcqoycPXCjCzWMmimb3IY8q9GKQOR8x6pNd3v1
	vV9x/nemRbYYcaNFH/8PW9wV5jMr26O2eKEmVrjIu17
X-Google-Smtp-Source: AGHT+IH8eALKGR5zCOl+R8P/WRpwrX9bwVJ1UVvKU1wnYrPDzGBLojCGZA3zFfLreOIaV7LXlozTy6gCHEDGSmyunFc=
X-Received: by 2002:a17:902:e78b:b0:25a:324a:9af1 with SMTP id
 d9443c01a7336-25d26e42154mr156019325ad.38.1757976652706; Mon, 15 Sep 2025
 15:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev> <20250915070308.111816-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250915070308.111816-2-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 15 Sep 2025 15:50:39 -0700
X-Gm-Features: Ac12FXyaCCOl3xi--ctLcow6nSSE2AxhgdJsl-2V89shjLzyvYzQhItoYJsNw60
Message-ID: <CAAVpQUBuV9ixMheieH137YNxZsKAZhQekjudpiw-=7DsvxV7BA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:04=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Add two functions to atomically replace RCU-protected hlist_nulls entries=
.
>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/linux/rculist_nulls.h | 62 +++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..eaa3a0d2f206 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -152,6 +152,68 @@ static inline void hlist_nulls_add_fake(struct hlist=
_nulls_node *n)
>         n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>  }
>
> +/**
> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
> + * @old: the element to be replaced
> + * @new: the new element to insert
> + *
> + * Description:
> + * Replace the old entry with the new one in a RCU-protected hlist_nulls=
, while
> + * permitting racing traversals.
> + *
> + * The caller must take whatever precautions are necessary (such as hold=
ing
> + * appropriate locks) to avoid racing with another list-mutation primiti=
ve, such
> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on th=
is same
> + * list.  However, it is perfectly legal to run concurrently with the _r=
cu
> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
> + */
> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node *ol=
d,
> +                                            struct hlist_nulls_node *new=
)
> +{
> +       struct hlist_nulls_node *next =3D old->next;
> +
> +       new->next =3D next;
> +       WRITE_ONCE(new->pprev, old->pprev);
> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev,=
 new);
> +       if (!is_a_nulls(next))
> +               WRITE_ONCE(new->next->pprev, &new->next);
> +}
> +
> +/**
> + * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
> + * initialize the old
> + * @old: the element to be replaced
> + * @new: the new element to insert
> + *
> + * Description:
> + * Replace the old entry with the new one in a RCU-protected hlist_nulls=
, while
> + * permitting racing traversals, and reinitialize the old entry.
> + *
> + * Return: true if the old entry was hashed and was replaced successfull=
y, false
> + * otherwise.
> + *
> + * Note: hlist_nulls_unhashed() on the old node returns true after this.
> + * It is useful for RCU based read lockfree traversal if the writer side=
 must
> + * know if the list entry is still hashed or already unhashed.
> + *
> + * The caller must take whatever precautions are necessary (such as hold=
ing
> + * appropriate locks) to avoid racing with another list-mutation primiti=
ve, such
> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on th=
is same
> + * list. However, it is perfectly legal to run concurrently with the _rc=
u
> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
> + */
> +static inline bool hlist_nulls_replace_init_rcu(struct hlist_nulls_node =
*old,
> +                                               struct hlist_nulls_node *=
new)
> +{
> +       if (!hlist_nulls_unhashed(old)) {

This is already checked by __sk_nulls_replace_node_init_rcu().


> +               __hlist_nulls_replace_rcu(old, new);
> +               old->pprev =3D NULL;
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  /**
>   * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>   * @tpos:      the type * to use as a loop cursor.
> --
> 2.27.0
>

