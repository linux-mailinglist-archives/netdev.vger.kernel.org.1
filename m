Return-Path: <netdev+bounces-246724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF3CF0A98
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 07:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E95B3018185
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 06:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4B2DECBF;
	Sun,  4 Jan 2026 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icOJK9J9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0202DF3DA
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767507776; cv=none; b=OrTY7EyB47JTFBT9CGrElfIBpo3BGScwyBTJVaz92YdrvkDG7toJih+9U+EZeC6HP4A6ouoH2+Vg/KoljXBu3perYe9tExp4AKHnOHNiInXxan7Blg8MdN/Vz3zruabxmL0ijBVerQfecX6qoW+dJ23AWwymqr9WjL2cCNqtwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767507776; c=relaxed/simple;
	bh=nmvNTEn2d2Kw218CvlRrrbyqxjZtPZvg0zO+e9VgXnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHeVcNaU/CF+H7l30WVA7HHXOtXp1Cn7UbfgPUnOFWh1ountdDEQ2weoZvkvX6oW7fX7yo/TFgc5Y8cqPjzzUAJjg8HHf2pwr+1qNh9g6Cx+HDTdiJSy3LzBCO+kwesrzQiMIWlyEcIU1SkAQBjS3B4AuEbddF3gur5vX96GDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icOJK9J9; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65d132240acso8011262eaf.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 22:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767507772; x=1768112572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFfPlAf5+lGKz5BhLDkt0s58hyQ5L/Fh79A19Mu9HtQ=;
        b=icOJK9J98CqvKrYWJIDE6E78U7K/zODI9DdmWPPhdKE4bVxbpqb1IM0QEfVwLwVHHg
         8Q047gkcbk7CsRHRs9TE/lrNHIO2c/lxMLydrTykBUmiFtZje2Qb/XwiPm5I7EFSnTnM
         ZKGndtdjvs4zjPf+LBydoBBaTnwefFLS/swwfTHR4XAUexVpLQnPWWDyHAhud8f9yNsG
         sS7Ul7CIPsj+S9/5U2x5K1soCPVIdMIDMsVfsJWdGI4gQGIhgXlo4bnDkRaTXflT4iVs
         gRrSVHDRkxPdYaWyYhJYRtbPdX1EI0j2ckMmRH2djD5XMr83rOyq7MexuvVml29kZXZN
         TtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767507772; x=1768112572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFfPlAf5+lGKz5BhLDkt0s58hyQ5L/Fh79A19Mu9HtQ=;
        b=uAU7ZYXF4KLASEQJQDjYdhE6n0tI69P4I18QLF0z/Y3Y3jxGdJrncWWwEilhWn90y0
         9y7HmigT5IrfbSEgLGdbEawnsO8Rd/3MU/W2SnoPxOkpYBopwGE7qA+Ropq95F7R99/E
         ukgB2q8g/QoAe8qxgR1tZspgQSP+3SIA6QEDPMulawitXlPZyCcEkQepsWG2rtOgtHV1
         IvHbM83EnTnQoPOvZSS2M5r2YO6zchotrLY3YtwmpBLuL5WGJj8DbbKj6jyrQfgkZS6J
         4vUaRfsHW+GDWNUnZ/NW5uEqDwvKhatLqV4hTS8ahkwLzQ9UZIz927RtDEdY2SjD/2XI
         cQyw==
X-Forwarded-Encrypted: i=1; AJvYcCUtE39ZtytQS8ENYXxiftH3NZhZtaOD+Xuq6amjU277ibobuSj4nZhcWxMEjoUBsQngs1TnkgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjH1fWITyqSdxldYzy2GMdetUPvJTc4ouPBmWpI84KdyzAOBEA
	2J6c1VWWJhBpyKXYSBs0Ad4l94Fyx90HBfDilLlO0hgs0Yka8Oq0uULGDabVJhRxiXuyg1/288w
	M7x1r5APqLBh37ZKe8xrKpCqZSXUGI+4=
X-Gm-Gg: AY/fxX5YOUZQRCotOoifH6W6khq87bICYqSoPjOjM1Zn4s8i/bM3fxSWZd2Eehu1FOH
	1FFjU+R6+89LMzVxzUp0vQ2aLoSjX0IEGlRTlOUw3TSf8BruIXgVgWHz0SqktyDRn6DxVEfK15y
	q4DcIDPbRUHg+TS6OuC8qsxWhq8m8AVjeTJeh02uvgzTUSp4j+nap9y0bY/xEZpC0k/FkRnTzfs
	Dww9kFc+gZ+9xZ/yaaobCuhuqy/3EDKQNniT/olXCDIjFUVKXDeRQjGcZRk2CKKBBdgORls
X-Google-Smtp-Source: AGHT+IHKUzNaqXfAAOXTQH/wyhLdPifEG8hdfQus5/ZP24EhvnoebGBAh1/QoRljvFz3JP4QEo0R0qH1KXixAhwxZ7E=
X-Received: by 2002:a05:6820:330d:b0:65c:f046:bb71 with SMTP id
 006d021491bc7-65d0ea9933fmr13839045eaf.46.1767507772044; Sat, 03 Jan 2026
 22:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104032313.76121-3-kerneljasonxing@gmail.com> <e15de586e958d118e15c59026406ca4df756ccd9075fdcedd458639685b661a9@mail.kernel.org>
In-Reply-To: <e15de586e958d118e15c59026406ca4df756ccd9075fdcedd458639685b661a9@mail.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 4 Jan 2026 14:22:15 +0800
X-Gm-Features: AQt7F2rOvf6soK_ZUGhuzyLkXSDXSaX75Goy7BHhQb-bgoLkIADQtPUhfMbpsMo
Message-ID: <CAL+tcoB6eCogZXXxDQ58nxp-VxWFOPR2DP4pyLVxGtjXdWPQXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] xsk: introduce a dedicated local
 completion queue for each xsk
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernelxing@tencent.com, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 11:39=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f41e0b480aa4..0a724cf20fcb 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > +static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
> > +{
> > +     struct xsk_buff_pool *pool =3D xdp_sk(skb->sk)->pool;
> > +     u32 idx, addr, pos =3D xsk_get_start_addr(skb);
>              ^^^^
>
> Should addr be u64 here? The lcq->desc[] array stores u64 values
> (descriptor addresses), and xskq_prod_write_addr() expects a u64 paramete=
r.
> Declaring addr as u32 truncates the upper 32 bits when reading from
> lcq->desc[].
>
> For reference, struct local_cq in include/net/xdp_sock.h declares:
>
>     u64 desc[] ____cacheline_aligned_in_smp;
>
> And xskq_prod_write_addr() in net/xdp/xsk_queue.h has signature:
>
>     static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx,=
 u64 addr)
>
> If a umem is large enough that descriptor offsets exceed 4GB, this would
> silently write incorrect addresses to the completion queue, causing user
> space to receive corrupted descriptor addresses.

Yes, it can happen. Thanks for pointing this out.

