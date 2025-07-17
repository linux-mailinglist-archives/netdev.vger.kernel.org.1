Return-Path: <netdev+bounces-207895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC1B08EEF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE141C22BD6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C142F7CE7;
	Thu, 17 Jul 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQcFq45c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226902F7CE0
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761677; cv=none; b=qLP10DYs6HL9y2r1sFzZ090gSZcUYErqHE4Y9ksJt1ASSJKDtV/SZJjbYuy7BH0SIUd7CKBF2AjCQKiJiQ2UaQwJTmfqZ3xMQDm9ZE++9o79/n89ySuxYbi+GDXoFyFsxT+uBmvO3GHpYi6qhwaHbCahL8cdmVF6+PbTaTF2osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761677; c=relaxed/simple;
	bh=U+W7V/eBIcH14n9hOuoTsK5rPYAZFYZ37JZDfmjgEj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTCP+CC+zqAeE8FWzopL0iPLosyWXZcSCeOGTTG1xHGnYv+A6TI3zJg4ttG/pnqYHvNbQ+4NrvxzHRjiMr4Hu/CuG+VCcYCUS1jrffTiUK7ykotWBlw05IR4+oqHtQ0AawqIUvQz/itQtjYyXqNgNQ94sEIKM41DOV4HZhOzvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQcFq45c; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab86a29c98so328291cf.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752761675; x=1753366475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9ESjmeueF/M4Xppi4ZUOzJRt1aYtYcUoC7SokY7JSU=;
        b=hQcFq45cpNWJxpc+h2LMcWFyum13vQgXs5rKUMBfpmVm3STVkglmmi0zyG2X1YwBXo
         CERGFo035rAe4+3mIT230YG/qSRvDpejnMgOROB8TckT1+9KkP4/2C9lJA5U+zfIODZ3
         5cyChFU7VesCtltBTYxNvFEzkuw1OJ4jajEFXNpnbpIaMOGxA6B74bF0gSZE1sOeH3Ai
         xGbGfnKMh6PjiPI+Ty6ldngg885vDX+5bCToZceAv8SKa+dOg2TPa1GHzE2pN4xbHkeH
         mnotjdaOb9TlsvYLHhUhdPx8Nl9OVSWD4uh82BIY5l3pOA64uMWaIyGmIMW+VxTWMnkc
         6iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761675; x=1753366475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9ESjmeueF/M4Xppi4ZUOzJRt1aYtYcUoC7SokY7JSU=;
        b=GoSoDK0n8v6bs8/WEgnQ+q9nCFyFw2UaUql3DJVMoLMdBfyZmKihIvrWmm/NWL39F5
         uTSee66MDrNP0vBdmu2SqEMaRLwBLakQ4vKo/BR9WOZwtkPDOMwiA3q2+w3Qazi7FEWd
         uiXOfOy7swQ97StyNhtlMJVH6fPQAN8ogMllQ0MLkIZ4Lm5f6jEKXrvOXUTub5RByG7r
         jwKufmEY0Qq7FxOS2DGsH08xoAkA46UL1futwFSWhxDchZqjed4/rHRR6SHXY5Lfyirl
         qE6w/EDTTs0h5HnnmcuiLXDlO3WXQQvIZW7ZT781KoEYQHk7ngWFpXhq3yqVfdHU7JXi
         uCfg==
X-Forwarded-Encrypted: i=1; AJvYcCWq0neRMUgCBAJOzGovBW+0aCSVPE2Z/OiFUuCrnv2hciAwEUtymxdfyiZqEcm7eUTgLm/Sklw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHxGxm95zwRPXWyNFsSf75RK1gdmb6HXBVAOuCMi1q3ean+Tb
	XR0X8IQt/wSib0R85d2Xj6jRfjl7cN9TRe6UKR7iNn/OWSY6WeuPrbkSgOoZ8S4wEs4eaRxFdU0
	pCHKR8+rBB/MkUK2BG2Uk4tyC1Zpqr4q6qIY9w1Px
X-Gm-Gg: ASbGncsk9K4kuvD5B59JH/lBgNb0d/wI66PVs2x3q8KUvi0qU8mgy1llIPQ4miyy4ZQ
	InYGcvJ61oqJIzNux7vfHEYCKbgAdoUVqLZx5rm241WqLN4svtWSLOp9WAW/v0AslBX1TGVE/ov
	mgWoLE88pQROjVz9/D5Qsjf1nU/g9looLxAnVsSgo0GldxLlmFS+jDjE2hT1lFmzUB6T5QBqUxi
	NtCS88=
X-Google-Smtp-Source: AGHT+IFGs+/HNcY99e2QwQVRt2HyixISJJQKpTcBz8kXHPf6UsQhzu5BIRM7GUTQkIr8p5fP7Z/e5JgqKP3xcxbCA8o=
X-Received: by 2002:ac8:7e93:0:b0:4a8:ea8:67e with SMTP id d75a77b69052e-4aba2bf7196mr4450451cf.2.1752761674411;
 Thu, 17 Jul 2025 07:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713152253.110107-1-guoxin0309@gmail.com> <9c67190f-62c2-4498-937d-5213de1a3fe0@redhat.com>
 <CAMaK5_jfKogtZhdtBn91W44wrsWjE09Vm=76T1fXxemiA6pSVg@mail.gmail.com>
In-Reply-To: <CAMaK5_jfKogtZhdtBn91W44wrsWjE09Vm=76T1fXxemiA6pSVg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 17 Jul 2025 10:14:17 -0400
X-Gm-Features: Ac12FXwtCU3EkR1PkyXKIuFb9Wd4mLlCUJFg0k_FYCGXwusoZJiXkfX6Xkha1UI
Message-ID: <CADVnQym_hhAoM2nvYyz2vR1zJTcAP0FzOZ-st0SfXE=6g68eVA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: correct the skip logic in tcp_sacktag_skip()
To: Xin Guo <guoxin0309@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:36=E2=80=AFAM Xin Guo <guoxin0309@gmail.com> wrot=
e:
>
> Hi Paolo,
> Thanks for your review, let me explain in the thread first.
> 1)let me start from tcp_sacktag_skip, the definition as below:
> static struct sk_buff *tcp_sacktag_skip(struct sk_buff *skb, struct sock =
*sk,
> u32 skip_to_seq)
> {
> if (skb && after(TCP_SKB_CB(skb)->seq, skip_to_seq))
> return skb;
>
> return tcp_sacktag_bsearch(sk, skip_to_seq);
> }
> the input skb is a hint to avoid search the RTX tree, and the condition i=
s:
> skb->seq > skip_to_seq(so skip_to_seq cannot be included in skb),
> as below:
> 0----------------------------------------------|------------------>+ skb-=
>seq
> 0--------------------|-------------------------------------------->+ skip=
_to_seq
>
> 2)let me check the code snippet in tcp_sacktag_write_queue()
> the code try to speed up the search by using tcp_highest_sack(),
> the code is from the rtx queue is a list, but now the rtx queue is a tree=
.
> the mean is that if the start_seq >=3Dtcp_highest_sack_seq(), the we use
> skb=3Dtcp_highest_sack() as a hint to speed up the lookup(avoid to
> lookup the tree).
> so we can see that the skb->seq <=3Dstart_seq.
> then if we use the skb and start_seq to call tcp_sacktag_skip(),
> the tcp_sacktag_skip will go for rtx tree lookup, so
> code snippet does not take effect.
>
> static int
> tcp_sacktag_write_queue(struct sock *sk, const struct sk_buff *ack_skb,
> u32 prior_snd_una, struct tcp_sacktag_state *state)
> {
> ...
> while (i < used_sacks) {
>
> if (!before(start_seq, tcp_highest_sack_seq(tp))) {
> skb =3D tcp_highest_sack(sk);
> if (!skb)
> break;
> }
> skb =3D tcp_sacktag_skip(skb, sk, start_seq);
>
> walk:
> skb =3D tcp_sacktag_walk(skb, sk, next_dup, state,
> start_seq, end_seq, dup_sack);
>
> advance_sp:
> i++;
> }
>
> 3) on the other side, let me show the logic in tcp_sacktag_bsearch, the l=
ogic is
>    the skb->seq should be met:
>    seq=3D<skb->seq and seq<skb->end_seq
> so the seq should be included in skb, the log is not consist with
> tcp_sacktag_skip().
>
> static struct sk_buff *tcp_sacktag_bsearch(struct sock *sk, u32 seq)
> {
> struct rb_node *parent, **p =3D &sk->tcp_rtx_queue.rb_node;
> struct sk_buff *skb;
>
> while (*p) {
> parent =3D *p;
> skb =3D rb_to_skb(parent);
> if (before(seq, TCP_SKB_CB(skb)->seq)) {
> p =3D &parent->rb_left;
> continue;
> }
> //[Xin Guo] at here seq=3D<skb->seq
> if (!before(seq, TCP_SKB_CB(skb)->end_seq)) {
> p =3D &parent->rb_right;
> continue;
> }
> //[Xin Guo]at here seq<skb->end_seq
> return skb;
> }
> return NULL;
> }
>
> i hope that it is more clear now, thanks.
>
> Regards
> Guo Xin.
>
> On Thu, Jul 17, 2025 at 4:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 7/13/25 5:22 PM, Xin Guo wrote:
> > > tcp_sacktag_skip() directly return the input skb only
> > > if TCP_SKB_CB(skb)->seq>skip_to_seq,
> > > this is not right, and  the logic should be
> > > TCP_SKB_CB(skb)->seq>=3Dskip_to_seq,
> >
> > Adding Kuniyuki
> >
> > I'm not sure this statement is actually true. A more clear (and slightl=
y
> > more descriptive) commit message could help better understanding the
> > issue. What is the bad behaviour you are observing?
> >
> > Ideally a packetdrill test case to demonstrate it would help
> sorry that a packetdrill script cannot show the wrong behavior.

I agree with Paolo that having a packetdrill test case for this kind
of issue would be best.

Can you please explain why you are saying that a packetdrill script
cannot show the incorrect behavior for this issue?

Usually packetdrill is a good fit for these kinds of protocol
processing issues that do not involve performance or race conditions.

Here are examples of test cases that stress SACK processing behavior,
if that helps:
  https://github.com/google/packetdrill/tree/master/gtests/net/tcp/sack

Thanks,
neal

