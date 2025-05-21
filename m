Return-Path: <netdev+bounces-192153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E750EABEB39
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D64A6B18
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8822E22F74A;
	Wed, 21 May 2025 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eldYYpGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D171459EA
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804943; cv=none; b=C/tMyw6Bpr4KoqWJe0RvJIndRgrydVl1IdiEiTiAq9QDIJCqTIrgO5igA8FWcXsfhfE3iN2L+JZqpBVatmg119J9hhBJg4riT8kQokVLhQRiOePmqyJmlIwk+5NGf4E5Da3+InaGJI19+ABoVbm3+N7164hnKv0wMKMJi8WPXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804943; c=relaxed/simple;
	bh=tixqIQcduKf2tAEZ7tPACW3X71xMssHd0YmmZItpnFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=om2HgAupoDW9fe7TdAejqu8YKf3dlDVRxQAINnnVoOKpemeYLKNtvbni16VZRZXmjQkI5gglUDfRfSUC59KWnhlNwewPUl+JJomoc8hBMESoaJ/4WnWpu7VZhiygbDejOVbMfhTMzGulLpYGSwl7E/taRKgPC+GJqTa5elHdnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eldYYpGH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso219215e9.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747804940; x=1748409740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf7GkfJ8YuQ9gAhJcAbhAa/hdNoAzv1ECbunM6p8VSw=;
        b=eldYYpGHQVD6GD6oJWgCIHk7/wcEaxeOFBMpDIERXFB81K6rxV4RFmqKg4wBQdGFAD
         xRTpE5YJTcgE5OhEoBbw7G2dlwH4jHhk/WZFs67GgThObwtaaPzUI7S24GmXZQjidjuf
         AppkFx0vA2VfgTHdc4wW9xkHi/heyMj5m8zROEXNYLbFH5HqZdeHj7VFOG6kcEBMPONo
         KIz2zDgt8wga4MO9RXE+73QayJlFBhqqBZnLiNjENV9BEzg7wpXyGnLVA1ZAdVI0on18
         yHSvTJsdkrWgULjsvLVXJhraVBgzJFooo9ZM/NVnpWROohR3nBUJDo/+dJ9SmZDqTthD
         E/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747804940; x=1748409740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf7GkfJ8YuQ9gAhJcAbhAa/hdNoAzv1ECbunM6p8VSw=;
        b=YHgj5lKESUblllOE5d5uZypwXiZmuNZXA/RHKeK2Z7Mm3yg8TnMjf8W3XxTLqiJxCG
         iisJ2knuDwaHXG3ngfvSuGWlF05VXDstubERNjw7wNT17g8eHnpr4oLeT5e8Ba6bzeTp
         e3OpmEj3QzvxVKORvLmCr7OXNbmwl/rVxcHFa/2lgcHH0PWS+5JRBNuyPVoi6TR2XTaa
         o0N70G1HIhbPSkj2hEzkcjid7wYlVDVVmt6qWHKVN3i/4cWpTT8KzCryB7cTAIIM++2e
         n6bf0fWAvPcHLeGDHd7HcnzgZ/2DLorD+O0b7ydKgLb7oUIayX2Zo57oyPXoTfpuhixR
         2jCg==
X-Forwarded-Encrypted: i=1; AJvYcCX0nmSVD6UWzNCwEJTCSYdCyT4TjRwnMTqTNtENRKYnm3CsjZIK7hZ1lK9BtKxl2/qV14H2pWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPh6bdVEDEvxNjr3CD8vC+lsG0QejLm9ihb1UboOc5CsiqLlq9
	kuM1ZnSacNchXYaopM0Vb1X72M5mK5di/Jluv7wf/tbfmovUm4+nZcXGqE94EX3SrdKP6iUAy2J
	5kMLpsuFSQYf7+z41TXXiPjVq8U9cz67wpFqAyY4qF9gWGkqarXCaSqqD
X-Gm-Gg: ASbGncvYs2QBNDSyfrLk+nXy150H3IaHgo9prkiC5BAVOsbpWYJzOyfU5ioE1KRHaIE
	vXxOLS79YObU6GWC4SL6FZTCtsWLYGglNADLEGVLRsP0hR4prw0QCaHNwzgYMN95azqnBu0UOsm
	/jEP/LlvU9Kvj11xVGkmt9LpXHFAOANwzJuOC6/XJSkc1MvPO4xNh+8N9KgN21xkMjqSgAf/g1m
	tNV
X-Google-Smtp-Source: AGHT+IF5YfPNxW00EQZIxWo+YrQrc4LInR1njdfkcWfFBPEgE0/GWO0Jybf072hOz9bQgr30dT30Pl4vKA7ZCdnC1hY=
X-Received: by 2002:a05:600c:1f82:b0:442:f4a3:8c84 with SMTP id
 5b1f17b1804b1-443eef3cbcfmr7380695e9.2.1747804939586; Tue, 20 May 2025
 22:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
 <20250517001110.183077-7-hramamurthy@google.com> <50be88c9-2cb3-421d-a2bf-4ed9c7d58c58@linux.dev>
 <CAG-FcCO7H=1Xj5B830RA-=+W8umUqq=WdOjwNqzeKvJLeMgywA@mail.gmail.com> <abf16cc2-c350-430d-a2fd-2a8bedef9f34@linux.dev>
In-Reply-To: <abf16cc2-c350-430d-a2fd-2a8bedef9f34@linux.dev>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Tue, 20 May 2025 22:22:07 -0700
X-Gm-Features: AX0GCFtE2E5widA50MV8ndFWAuPVhKzT4evlMPgA6Ylurjfd7oa_lZTeop0nrqw
Message-ID: <CAG-FcCOPyAo6r3difj2pzUNE7DinTwespqPxw3k6bqjEPdNaoA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/8] gve: Add rx hardware timestamp expansion
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, richardcochran@gmail.com, 
	jdamato@fastly.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:53=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 19.05.2025 19:45, Ziwei Xiao wrote:
> > .
> >
> >
> > On Sun, May 18, 2025 at 2:45=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 17.05.2025 01:11, Harshitha Ramamurthy wrote:
> >>> From: John Fraker <jfraker@google.com>
> >>>
> >>> Allow the rx path to recover the high 32 bits of the full 64 bit rx
> >>> timestamp.
> >>>
> >>> Use the low 32 bits of the last synced nic time and the 32 bits of th=
e
> >>> timestamp provided in the rx descriptor to generate a difference, whi=
ch
> >>> is then applied to the last synced nic time to reconstruct the comple=
te
> >>> 64-bit timestamp.
> >>>
> >>> This scheme remains accurate as long as no more than ~2 seconds have
> >>> passed between the last read of the nic clock and the timestamping
> >>> application of the received packet.
> >>>
> >>> Signed-off-by: John Fraker <jfraker@google.com>
> >>> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> >>> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >>> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> >>> ---
> >>>    Changes in v2:
> >>>    - Add the missing READ_ONCE (Joe Damato)
> >>> ---
> >>>    drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 ++++++++++++++++=
++++
> >>>    1 file changed, 23 insertions(+)
> >>>
> >>> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/n=
et/ethernet/google/gve/gve_rx_dqo.c
> >>> index dcb0545baa50..c03c3741e0d4 100644
> >>> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> >>> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> >>> @@ -437,6 +437,29 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
> >>>        skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
> >>>    }
> >>>
> >>> +/* Expand the hardware timestamp to the full 64 bits of width, and a=
dd it to the
> >>> + * skb.
> >>> + *
> >>> + * This algorithm works by using the passed hardware timestamp to ge=
nerate a
> >>> + * diff relative to the last read of the nic clock. This diff can be=
 positive or
> >>> + * negative, as it is possible that we have read the clock more rece=
ntly than
> >>> + * the hardware has received this packet. To detect this, we use the=
 high bit of
> >>> + * the diff, and assume that the read is more recent if the high bit=
 is set. In
> >>> + * this case we invert the process.
> >>> + *
> >>> + * Note that this means if the time delta between packet reception a=
nd the last
> >>> + * clock read is greater than ~2 seconds, this will provide invalid =
results.
> >>> + */
> >>> +static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *r=
x, u32 hwts)
> >>> +{
> >>> +     s64 last_read =3D READ_ONCE(rx->gve->last_sync_nic_counter);
> >>
> >> I believe last_read should be u64 as last_sync_nic_counter is u64 and
> >> ns_to_ktime expects u64.
> >>
> > Thanks for the suggestion. The reason to choose s64 for `last_read`
> > here is to use signed addition explicitly with `last_read +
> > (s32)diff`. This allows diff (which can be positive or negative,
> > depending on whether hwts is ahead of or behind low(last_read)) to
> > directly adjust last_read without a conditional branch, which makes
> > the intent clear IMO. The s64 nanosecond value is not at risk of
> > overflow, and the positive s64 result is then safely converted to u64
> > for ns_to_ktime.
> >
> > I'm happy to change last_read to u64 if that's preferred for type
> > consistency, or I can add a comment to clarify the rationale for the
> > current s64 approach. Please let me know what you think. Thanks!
>
> I didn't get where is the conditional branch expected? AFAIU, you can do
> direct addition u64 + s32 without any branches. The assembly is also pret=
ty
> clean in this case (used simplified piece of code):
>
>          movl    -12(%rbp), %eax
>          movslq  %eax, %rdx
>          movq    -8(%rbp), %rax
>          addq    %rax, %rdx
>
>
Thanks for the analysis. I will update it and send in the v3 series.
> >
> >>> +     struct sk_buff *skb =3D rx->ctx.skb_head;
> >>> +     u32 low =3D (u32)last_read;
> >>> +     s32 diff =3D hwts - low;
> >>> +
> >>> +     skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_read + diff);
> >>> +}
> >>> +
> >>>    static void gve_rx_free_skb(struct napi_struct *napi, struct gve_r=
x_ring *rx)
> >>>    {
> >>>        if (!rx->ctx.skb_head)
> >>
>

