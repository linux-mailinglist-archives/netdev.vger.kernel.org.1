Return-Path: <netdev+bounces-84947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5231898C3B
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DAC28156C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379751B7F7;
	Thu,  4 Apr 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITntyEsn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9D18654
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248578; cv=none; b=S5oxv4M1j0S/kiWoCV40Hjz3AAQmp3guFEwemQYjMCF21UTtqo351VxJcN9qNQZZ7tG8XcCKqT0PpXvdhb9afG0E2oijuzGo86i99u9DlvPmMBmSZSjSMJbzr/fFl5q10hyFfyfOQI2ZfI/KrIBf5umBiBvJxfiBc4lgreHDASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248578; c=relaxed/simple;
	bh=R/g3dv6LqrkP66NB/YV8Sx2MFTe04H4UIC9uvSl7U54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoEfq2ELpgludALXRkvoFosnp9Ob4Q5Y8hk0kRbAxDsiE3uG6udN9e2H80am+64CW2OKRMUl/8qw3P7XlZnNL7ib0kfWCSPbOsmzxeFMbZ3DOUAoCHmbEnK6iwkaX66CItnSOT1WOqg5fcow7t3RrNJlSG8VaxId50FqJBa9tQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITntyEsn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e0c7f7ba3so223a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712248575; x=1712853375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvH5ydl2z0chJsMooq546b6un1fwypQqhroLvMmqvLQ=;
        b=ITntyEsnPhTWtoTN2pVc440CZhvk6FBFrQdJ3Tv5D8oov3kNlT5HBP/W7wdc+DlziI
         lY74BZlVNpWtOI1pe9FflqtIarRtwP62uIDE0m7BZQFNa74nNVJOJI8VfsQvg7M2Gpmf
         VJjseHRbm7ZD8hfWUo/pErYQBIbadNyHGCDiam0ffInkCR4xh1L7+NiiaMQqVyMAi8ft
         QfTzXR91pC26cSRolsO2v1+5JTuOJW5CmvOQw5d3T3Y5yOG2y1g/nGIFH4u04Vx9FeBi
         8pXFdSpWifpiLfvNtsFs2ITWvZdPe91gZGXjAbcGnWdCWCZWpmTKZZYeGFkyfJpIXpWE
         CN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248575; x=1712853375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvH5ydl2z0chJsMooq546b6un1fwypQqhroLvMmqvLQ=;
        b=PyJ9FlOlvcEG5zopFqY0XCRekz9ewE7YZT4AAAGVH3+L3zhivpDGLW3rB7pY/XCo79
         vbLHtc26GVElecPh2+O//0Q8EOV68kx33WIwhMxTQHLCIwmkIPG9YbGffT3fyVTOq7bF
         y+1fiQ8wObv1OiR9xf2Mgkgggdjz8w+Khl23TR4KuQFrzngCK7laFvNFrUXDKEdw8tn+
         A3Xno7uK5+6l44/ajE55+nYZK/INa2lxIUXzxGBbQ7ggW7Q4GADOCPpBWKCHX5FfFTwL
         IFDa9icEOOy7R0ZD0KGqJH1vjFGN5HNvZb0jxkcv6MTc/AxJSTW8cnmu5iesnhTCpnBs
         uD8g==
X-Forwarded-Encrypted: i=1; AJvYcCX3Wte0OxsmfAOwSh1/6DNJcAuxQz4ugkUMQsh8pcjZDcpaHs60oaOidlKg0IOkqr83JUqYwh77WV0LrVID+57DKQJaSQx6
X-Gm-Message-State: AOJu0YzZiZrTIKfl98m1GolgYIGvTqE67D5uNWTy99WzV0KjHdDomYa5
	3PQp4MUzF7ZLNSQzUw2IGfK7zCQ3lrW3Xc+gr4FOER3Khl5RNlbkoAASslAnJ1BtAFaQTt3GLvG
	RbPsohEgsM428RXAdLlertEZL1hK5BgXvRU15
X-Google-Smtp-Source: AGHT+IFISNxIVz1JX7Gfm37eigsN68kKdXC1+3w5v3Dc+WTDXYYpWQFyvBn84NKQ2a4innSaz646D3RokYUQi738Xp4=
X-Received: by 2002:aa7:cd59:0:b0:56e:22bc:754a with SMTP id
 v25-20020aa7cd59000000b0056e22bc754amr96074edw.0.1712248574622; Thu, 04 Apr
 2024 09:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404145939.3601097-1-leitao@debian.org> <20240404145939.3601097-4-leitao@debian.org>
In-Reply-To: <20240404145939.3601097-4-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Apr 2024 18:36:00 +0200
Message-ID: <CANn89iLhi365XA2-5vQwf+ELRYEep=NFSHxVAE=v0cXjpANh4w@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: dql: Optimize stall information population
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:00=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> When Dynamic Queue Limit (DQL) is set, it always populate stall
> information through dql_queue_stall().  However, this information is
> only necessary if a stall threshold is set, stored in struct
> dql->stall_thrs.
>
> dql_queue_stall() is cheap, but not free, since it does have memory
> barriers and so forth.
>
> Do not call dql_queue_stall() if there is no stall threshold set, and
> save some CPU cycles.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/dynamic_queue_limits.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic=
_queue_limits.h
> index 9980df0b7247..869afb800ea1 100644
> --- a/include/linux/dynamic_queue_limits.h
> +++ b/include/linux/dynamic_queue_limits.h
> @@ -137,7 +137,9 @@ static inline void dql_queued(struct dql *dql, unsign=
ed int count)
>
>         dql->num_queued +=3D count;
>
> -       dql_queue_stall(dql);
> +       /* Only populate stall information if the threshold is set */
> +       if (READ_ONCE(dql->stall_thrs))
> +               dql_queue_stall(dql);

Note that this field is not in the first cache line of 'struct dql',
we will have some false sharing.

Perhaps we could copy it in a hole of the first cache line (used by produce=
rs).

struct dql {
unsigned int               num_queued;           /*     0   0x4 */
unsigned int               adj_limit;            /*   0x4   0x4 */
unsigned int               last_obj_cnt;         /*   0x8   0x4 */

/* XXX 4 bytes hole, try to pack */

unsigned long              history_head;         /*  0x10   0x8 */
unsigned long              history[4];           /*  0x18  0x20 */

/* XXX 8 bytes hole, try to pack */

/* --- cacheline 1 boundary (64 bytes) --- */
unsigned int               limit __attribute__((__aligned__(64))); /*
0x40   0x4 */
unsigned int               num_completed;        /*  0x44   0x4 */
unsigned int               prev_ovlimit;         /*  0x48   0x4 */
unsigned int               prev_num_queued;      /*  0x4c   0x4 */
unsigned int               prev_last_obj_cnt;    /*  0x50   0x4 */
unsigned int               lowest_slack;         /*  0x54   0x4 */
unsigned long              slack_start_time;     /*  0x58   0x8 */
unsigned int               max_limit;            /*  0x60   0x4 */
unsigned int               min_limit;            /*  0x64   0x4 */
unsigned int               slack_hold_time;      /*  0x68   0x4 */
unsigned short             stall_thrs;           /*  0x6c   0x2 */
unsigned short             stall_max;            /*  0x6e   0x2 */
unsigned long              last_reap;            /*  0x70   0x8 */
unsigned long              stall_cnt;            /*  0x78   0x8 */

/* size: 128, cachelines: 2, members: 19 */
/* sum members: 116, holes: 2, sum holes: 12 */
/* forced alignments: 1, forced holes: 1, sum forced holes: 8 */
};

