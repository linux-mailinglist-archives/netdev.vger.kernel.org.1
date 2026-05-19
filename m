Return-Path: <netdev+bounces-289497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKvKLrWCDGqmigUAu9opvQ
	(envelope-from <netdev+bounces-289497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:33:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39887581842
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABA3307E9B0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4D400E15;
	Tue, 19 May 2026 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cM7SmRZC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D8400DF1
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203966; cv=pass; b=Lx/wPk67CCEtO7dp0PjtQm7Kqk+r1AVBw1ufzdOh+q5o2a6cA1rNBr1dyCnvsdNftylcTvo0GcvjFtIyJ7OyTNkcsR5bHBzPiY8gh6YYI3wLx7mtP9IthPo7i+fjYZ/j0rHksu3kmNF0uJhV9AJRfeItr+dk8XH9QqLKwbAadyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203966; c=relaxed/simple;
	bh=siQVO2sQxemf4Uiqc4EspBf0wzllhMQs3CzU+GJb51Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDSccZiyIX/w8To7iy+oijGg4ZUH/am9Zo0iGg3P9ajoX6h4hKUlu8hSoocsHnTSD1choU8kb+UiCcI91eUEhkiUQg30T9MQkTHk4Obe2VLDppnLoIuk9LwyT4vu1M42VJWDbhizmfHjbVu21xA4Sd3z4G1jWIp6xKSdlu16Av0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cM7SmRZC; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J4KWvI829058
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:19:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cvhqFdFEaw6myv9osLkAkBoObyxXccXadGAoubACWjo=; b=cM7SmRZCYmul
	dE/iM0Q6jt9wxNUlA0u5d5+XuAUSMLKPILSBjs1Wtk2pWJq4q/uB7iE5KyZu/Tzk
	+FFx2mQdg/WXv8G1MKEBFzaOJr4dFKrUmoEFTyMKJnD3jfE3N+bP4p1KmF6yI+Mi
	x1XaLRtcehHvlTfBsngbltXdiEQIEV7rGw6tcsJcDSBenZPoZrAkQZNvE+DeP9WD
	qzCz90CS7DJglwWwBRXo2+A+o38R5pzmVY4ZqNda2DNc9z+db0ClKdSOFj9+cZBj
	f37BVjxBekdYFio13WhziXTKwLkkPVpqiJA3F05rk2z93cL8GaJAS2LC0g6icyP+
	3Acjc7fgeg==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e6pacgmtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:19:21 -0700 (PDT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8f848ebcbbso274667266b.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779203960; cv=none;
        d=google.com; s=arc-20240605;
        b=N3Orfp0403FqXK+6myTtDWIa6mGUQAPvqXVT64a6xv7FoLlfOhsvPeFHJ5DzVyBYNt
         9T0fjiIrx+B8Hs19l2fLzUeJwUmsnJYoFhg94Aa7D+GiKS8GGlc/SQAutjWz/7ietFGV
         wxShQeFijT2EhWtjJjSTo0YEBCnr/NCWef6xMn+22NVJ2Ar0bAAgRhQucyYXXz0pqW83
         QV+nCoRmUlm7WIe1rIIvlm65O6lT9EIggAHN2WAOv9f9dauoaps44bf/bCOOVVypKebP
         YdKIuzEfmzOn9r/RwXKKvpBAS2r5/K30w2jsWQzJswUesxqvDIuzzaROM+ao09MNvAd7
         eSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=cvhqFdFEaw6myv9osLkAkBoObyxXccXadGAoubACWjo=;
        fh=JJMio+WWdOx0gIkkbGtUTtGS/J7iSrStSmh12xgY2rM=;
        b=Xfpm+PXzCeVBwUEOBKtVQMZhHOpPJ7O2rggXjMyjBlEz5fYtg0JIuFBOW6W5/asBYN
         tmZoAytP4LwzTLURUrdZUc8cTpifkuwd5aawGb1KC9Us1kmoT8UisGQdDzMKeA72dbeF
         a03BbIrlHriqF6zZTKrnwZubNTSVuxioXbFyUbPRQBTZjEZum0b1iExCqwq5G4TbBiGk
         obo7l7rjAC0740R/4WLIpQIbxaUBikLjcItkOf6ci1gvmdcZ8v3NOvgCO4IIqAgprcaF
         yfcLc7X/PGvM4pdd5UMEBSjkLB+paRYkF19TBDgmXS92X2GnyoJ6iSoiXmO2LyKwtcEn
         encA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203960; x=1779808760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvhqFdFEaw6myv9osLkAkBoObyxXccXadGAoubACWjo=;
        b=soX42FZ639/AQ9yz6p5r1uKDXUjmP8ZSzae0aiAWCNeN6fOrCBgRilYRn1E8A7Het4
         I2U8iYxC10DCXdGiX4P2jao9k3DBmemKIWm3Ym54nqld6sRF3Rchmv5EWqexRTpTqLYM
         WgV5b7ZnUAXGu9FCiQAyFKHId5zQEa7h+VLy4PFKDyLn6nsp51IABH2pMrCHo8qyWDy0
         w1EXrOiTNMSFJ3eA1QCRqehg4F+JYPrvW0RSCJY9OQFBXt7ll/eov0SNZtLFbGnf1qHS
         QhiDJMqkNBvhsultKK2HQ29p5YBj2RMEcWNrWQM6AVT97k8/9kXqSus1kdg4beDqwJrN
         ycdw==
X-Forwarded-Encrypted: i=1; AFNElJ8vTKGhieclNILgePZ1cEOqbMDe74OU30VWzs20KkzjA5hpAY6wZ4f2CxxDQpm+qtQBp9iXcO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kGtOmht+S9SMLgrHwG/J83M9FZkYa2ziYYD138YQaXFpVQCp
	6AplPoD1epRYETAaHVhPrri7j5g56QjavXWEphSz9rOsLQ+nozIHHtSzpTq0gAjM/bpKfHFFF8y
	dEatp2llv0DpEcaphocVNaiDX1An+c3jgYjKEqO2Wh7ZoYERLswkh5Bg9Vj//8poCxUsI9am93x
	Z/KmysefGs4t2FusMq8t5Zd+/OdJLOmdA=
X-Gm-Gg: Acq92OFQYH0Kae8DyASslJurwewUJN2nP3ZFjJKfCNB4/OzUglfuQUU1CU0DbwC7Osi
	WYbV6XzCM+4Lpmb362KhvkLo+mf5xDNvrInhhSjc98pP5eqp9eJrV8VNITlOj1lZrSVNHNfuRko
	cyOcNIW7sshUaZMPd1Ak/ce1FD9GCxA8CDMUk7TOFiZ3cGEvajkcESsErh4LgIZ/+XlrbHGKySd
	KQgyvZAuh6jwKk+QpdP0Pvh8HK4nV6UzEQ=
X-Received: by 2002:a17:907:c714:b0:bd0:7949:a931 with SMTP id a640c23a62f3a-bd517960723mr1182042866b.27.1779203960353;
        Tue, 19 May 2026 08:19:20 -0700 (PDT)
X-Received: by 2002:a17:907:c714:b0:bd0:7949:a931 with SMTP id
 a640c23a62f3a-bd517960723mr1182039866b.27.1779203959924; Tue, 19 May 2026
 08:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518153532.2835502-1-cleger@meta.com> <20260518153532.2835502-2-cleger@meta.com>
In-Reply-To: <20260518153532.2835502-2-cleger@meta.com>
From: Vishwanath Seshagiri <vishs@meta.com>
Date: Tue, 19 May 2026 08:19:07 -0700
X-Gm-Features: AVHnY4ISeSj-tWX2tmLsxva9JeDwShAViFq_TymQ9K5usF1cuLqmkszdGAaeUro
Message-ID: <CAJEWsO0hprYmXoGmkR1+yv+hM53dGVh5O=7M+xFAdqoQjKrA8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] io_uring/zcrx: add ctx pointer to zcrx
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: QzXt-SqjGLZURsTNBXWxT0dyETuY6zEA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1MiBTYWx0ZWRfX4v94b9JhbiM1
 2I4oiEa43+ufGi/PqZUGDjdyAEFA4SrFyXetQZFiNBploUQE1nS+90oAUKoDXYp29L2gl/1+dDK
 fNFLn4/4rBWGOeOUaPi/yp+g96tDqG2m8s/Sxb/GDYm2R9Pr7VMOKTnbxvViBXVXYmapbaUHQ+E
 qc2h3cYihXaMDKikM+0Xu+2LumJbYGMZyIuGbDE8s4orH7XekZ23f8dkQjeJ0yjZIVw4eAK5h1m
 4ZqFZUkrsX5f3NFvtRVKzfa95UJ5EBxeTETunNjNlB1H3uVLlZyHfcov4cf5MkxshoG7M9uHR3F
 4PFyRwpDcxDrz3YAvDq2Sk5rt2OARZuP6uyvLdQWaoU+Rx+wk98Jcj9bpIv4Sl7h0rzZEACK1NG
 QngCnZ/irxQi2tRRIw+PdlOwIO1GHeDK5gvK5Jk0ODEuFU3vih+7qz01Q18DQXBO5HmYeLvxe05
 IqSSoyV4he6i/D/K4cQ==
X-Proofpoint-ORIG-GUID: QzXt-SqjGLZURsTNBXWxT0dyETuY6zEA
X-Authority-Analysis: v=2.4 cv=TfemcxQh c=1 sm=1 tr=0 ts=6a0c7f79 cx=c_pps
 a=edIAN7ErZTGbxav20d8A7Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=DNv30csI2qpO98t81IsA:9 a=QEXdDO2ut3YA:10
 a=nIuFr-8touD1a-RngYHT:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289497-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.dk,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:email,meta.com:dkim]
X-Rspamd-Queue-Id: 39887581842
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 8:36=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@met=
a.com> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> zcrx will need to have a pointer to an owning ctx to communicate
> different events. Reference the ctx while it's attached to zcrx, and
> rely on zcrx termination to drop the ctx to avoid circular ref deps.
>
> Co-developed-by: Vishwanath Seshagiri <vishs@meta.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  io_uring/zcrx.c | 39 +++++++++++++++++++++++++++++++--------
>  io_uring/zcrx.h |  3 +++
>  2 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 3f9632e7790a..34faf90423f4 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -44,6 +44,17 @@ static inline struct io_zcrx_area *io_zcrx_iov_to_area=
(const struct net_iov *nio
>         return container_of(owner, struct io_zcrx_area, nia);
>  }
>
> +static bool zcrx_set_ring_ctx(struct io_zcrx_ifq *zcrx,
> +                             struct io_ring_ctx *ctx)
> +{
> +       guard(spinlock_bh)(&zcrx->ctx_lock);
> +       if (zcrx->master_ctx)
> +               return false;
> +       percpu_ref_get(&ctx->refs);
> +       zcrx->master_ctx =3D ctx;
> +       return true;
> +}
> +
>  static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
>  {
>         struct io_zcrx_area *area =3D io_zcrx_iov_to_area(niov);
> @@ -531,6 +542,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct i=
o_ring_ctx *ctx)
>                 return NULL;
>
>         ifq->if_rxq =3D -1;
> +       spin_lock_init(&ifq->ctx_lock);
>         spin_lock_init(&ifq->rq.lock);
>         mutex_init(&ifq->pp_lock);
>         refcount_set(&ifq->refs, 1);
> @@ -580,6 +592,8 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
>                 return;
>         if (WARN_ON_ONCE(ifq->netdev !=3D NULL))
>                 return;
> +       if (WARN_ON_ONCE(ifq->master_ctx))
> +               return;
>
>         if (ifq->area)
>                 io_zcrx_free_area(ifq, ifq->area);
> @@ -656,17 +670,24 @@ static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
>         }
>  }
>
> -static void zcrx_unregister_user(struct io_zcrx_ifq *ifq)
> +static void zcrx_unregister_user(struct io_zcrx_ifq *ifq, struct io_ring=
_ctx *ctx)
>  {
> +       scoped_guard(spinlock_bh, &ifq->ctx_lock) {
> +               if (ctx && ifq->master_ctx =3D=3D ctx) {
> +                       ifq->master_ctx =3D NULL;
> +                       percpu_ref_put(&ctx->refs);
> +               }
> +       }
> +
>         if (refcount_dec_and_test(&ifq->user_refs)) {
>                 io_close_queue(ifq);
>                 io_zcrx_scrub(ifq);
>         }
>  }
>
> -static void zcrx_unregister(struct io_zcrx_ifq *ifq)
> +static void zcrx_unregister(struct io_zcrx_ifq *ifq, struct io_ring_ctx =
*ctx)
>  {
> -       zcrx_unregister_user(ifq);
> +       zcrx_unregister_user(ifq, ctx);
>         io_put_zcrx_ifq(ifq);
>  }
>
> @@ -686,7 +707,7 @@ static int zcrx_box_release(struct inode *inode, stru=
ct file *file)
>
>         if (WARN_ON_ONCE(!ifq))
>                 return -EFAULT;
> -       zcrx_unregister(ifq);
> +       zcrx_unregister(ifq, NULL);
>         return 0;
>  }
>
> @@ -711,7 +732,7 @@ static int zcrx_export(struct io_ring_ctx *ctx, struc=
t io_zcrx_ifq *ifq,
>         file =3D anon_inode_create_getfile("[zcrx]", &zcrx_box_fops,
>                                          ifq, O_CLOEXEC, NULL);
>         if (IS_ERR(file)) {
> -               zcrx_unregister(ifq);
> +               zcrx_unregister(ifq, NULL);
>                 return PTR_ERR(file);
>         }
>
> @@ -787,7 +808,7 @@ static int import_zcrx(struct io_ring_ctx *ctx,
>         scoped_guard(mutex, &ctx->mmap_lock)
>                 xa_erase(&ctx->zcrx_ctxs, id);
>  err:
> -       zcrx_unregister(ifq);
> +       zcrx_unregister(ifq, ctx);
>         return ret;
>  }
>
> @@ -932,12 +953,14 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
>                 ret =3D -EFAULT;
>                 goto err;
>         }
> +
> +       zcrx_set_ring_ctx(ifq, ctx);
>         return 0;
>  err:
>         scoped_guard(mutex, &ctx->mmap_lock)
>                 xa_erase(&ctx->zcrx_ctxs, id);
>  ifq_free:
> -       zcrx_unregister(ifq);
> +       zcrx_unregister(ifq, ctx);
>         return ret;
>  }
>
> @@ -967,7 +990,7 @@ void io_terminate_zcrx(struct io_ring_ctx *ctx)
>                         break;
>                 set_zcrx_entry_mark(ctx, id);
>                 id++;
> -               zcrx_unregister_user(ifq);
> +               zcrx_unregister_user(ifq, ctx);
>         }
>  }
>
> diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
> index 9e1a6a1b11e8..6b565d0bf6da 100644
> --- a/io_uring/zcrx.h
> +++ b/io_uring/zcrx.h
> @@ -73,6 +73,9 @@ struct io_zcrx_ifq {
>          */
>         struct mutex                    pp_lock;
>         struct io_mapped_region         rq_region;
> +
> +       spinlock_t                      ctx_lock;
> +       struct io_ring_ctx              *master_ctx;
>  };
>
>  #if defined(CONFIG_IO_URING_ZCRX)
> --
> 2.53.0-Meta
>

