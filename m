Return-Path: <netdev+bounces-207884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F8B08E5F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D55584D9F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247052EBBB0;
	Thu, 17 Jul 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k32SHnNU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2C2EBBAE
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759412; cv=none; b=Xx8o0Dqos70L6HSDM2+t0zmXcqasatV1mAua3Bmi8A4NLG3g82WK2pAE6Wnknttv68fevaDZ+9en9RbBeCGwGEYS/4BXFJk7ucsxyQdaCpYHRipqELAeN5hrM5nIHqRoPPUDvDj2c9HbVJRYPq33aP6uIBQsyyoEx7uurA3+sJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759412; c=relaxed/simple;
	bh=vMnHwSkCm7ihNeaTUdyx1lYtm9xJAnm/KEkCwbCXZL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLk0xiqpDkhemffmOQ0Q+r2ch851pBuBNFWLWKZyA8MDt3bmp1q850vfQkNZja8PVEr4N2u0hrpqLATkErXIgNHI1IfhiC6A2fKoX8CLXWnqf4x+imadeN4dEkj1OGZUUPB1i+vxLRt2xaladoP4mGyJF7ROOlt0B3WjnH8W70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k32SHnNU; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4aabba49c97so1618721cf.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752759409; x=1753364209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5z7SzUr4ZS38oRGudaJel6QkUl6iuR0rBqk5eLZDeY=;
        b=k32SHnNUVlYlg5fY/jto0lMC0+2IgEzsGGG4V2E5Bv/pVd0NnjU5o0cVTnBnhzjB7l
         6T5EjbXyVtPNZjnRW7O930pEJOIwb7tYDIh6wh3CGor1R0XNFkMl6J0kwkHtsiFCpwpz
         dbMH7bq6MZzNj3tvnKR6lOBYL346BfaEXJAYc8pzD+8Ux/lvlg94mYdefArAsj7jg0nU
         2lMacRWQ7+To5gORzMviuWdYUvSmE5iE/8kaZH6m40Fp51RwHGAIk132SR+aOuq0sOIR
         yacZAn58h0oh4B74fH1WkxNtBqvyVaAIojTSuuO9zh1E9FnRewfSEXqPHPc5HAqPBbF6
         7VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752759409; x=1753364209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5z7SzUr4ZS38oRGudaJel6QkUl6iuR0rBqk5eLZDeY=;
        b=Bd8UsmW06x9zYKen71Ph+wsdswOC85VmY0jjCDVdXZxsrqlkjYuVapZLVUox/OfKeA
         RrWmuy9agHaL1gDjhOI5U+64UuplLcRiyO2wE4pqNkwmQQDE70LiNar+chUgg5EEvtxl
         602qVk2cu5OyIPjjnrwnnlzOr1baVoXS9yE3KsswIIWnzOl3bY29Y9FDnz9/JlrVmE7h
         ZZxgzReCoISK00P4Ii9/ONRqPxQdOEFhLeOWWdhtw/ry/ScFVMJY1CuC663kelXYJExB
         ObzaPHd3BNGJGkZ2QGnkxcEs9zhyDbF9/1FeR44PFcF1F/4YpEhkxCW4okjTEt1WMcUo
         8CcA==
X-Forwarded-Encrypted: i=1; AJvYcCVYr/YKNxnAT5X6+xIyC0KjOyLCngTcw04Hd0iaGlnDQ7z7+HE04JXqsZVcFCeqGRxWlVHwCPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0iDkZW8MPy3Ysp4pq84OOJ7FNflFghyjkgEiyjmMQy7kQgLw
	EeAEgef3brWfEckF8/HGRG7y5A2nDyURJuZPWafbLAVajyRuuILWobzp+0gee4mjInxHmJNqsQJ
	gtnUYqhkvtKpG/XHDumqQRPm2UHk02g==
X-Gm-Gg: ASbGncvaoLAyIC2pkA3NShXbHLSTBil70Dwvl3zdIz+CaINr5vP04wvGbxd7Qk2NK0S
	AcQbytRckD7WiCdfYVBE1d0lzJ2ugGH0Tx44mIq8DjJ+m/4aB6g0I98OKhkKl2St2qqB/zeSXHC
	9/o+RCHO0Uv467OIW7klnLkKnbgqW9rk/t3rxJXLbPS9S4gy80LTBaEyzV36BJBbkVjHUMc7PyI
	50O+sY=
X-Google-Smtp-Source: AGHT+IHOxwSLW2L1gOctHhI8Gi7sFj8m0GX8K2n4aTiffIRo+3pDHSvWxaUdhnDz2d4d/E+0n6GzYcvG1lr7OmwcO6M=
X-Received: by 2002:a05:6214:5bc6:b0:6e8:f645:2639 with SMTP id
 6a1803df08f44-704f48482b3mr44525686d6.5.1752759409075; Thu, 17 Jul 2025
 06:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713152253.110107-1-guoxin0309@gmail.com> <9c67190f-62c2-4498-937d-5213de1a3fe0@redhat.com>
In-Reply-To: <9c67190f-62c2-4498-937d-5213de1a3fe0@redhat.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Thu, 17 Jul 2025 21:36:37 +0800
X-Gm-Features: Ac12FXyMOz1NRPMrkUed5DUljPyzHSXcVcrs5hbH0jSDPYM76QwQTBfEEg8MSpA
Message-ID: <CAMaK5_jfKogtZhdtBn91W44wrsWjE09Vm=76T1fXxemiA6pSVg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: correct the skip logic in tcp_sacktag_skip()
To: Paolo Abeni <pabeni@redhat.com>
Cc: ncardwell@google.com, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,
Thanks for your review, let me explain in the thread first.
1)let me start from tcp_sacktag_skip, the definition as below:
static struct sk_buff *tcp_sacktag_skip(struct sk_buff *skb, struct sock *s=
k,
u32 skip_to_seq)
{
if (skb && after(TCP_SKB_CB(skb)->seq, skip_to_seq))
return skb;

return tcp_sacktag_bsearch(sk, skip_to_seq);
}
the input skb is a hint to avoid search the RTX tree, and the condition is:
skb->seq > skip_to_seq(so skip_to_seq cannot be included in skb),
as below:
0----------------------------------------------|------------------>+ skb->s=
eq
0--------------------|-------------------------------------------->+ skip_t=
o_seq

2)let me check the code snippet in tcp_sacktag_write_queue()
the code try to speed up the search by using tcp_highest_sack(),
the code is from the rtx queue is a list, but now the rtx queue is a tree.
the mean is that if the start_seq >=3Dtcp_highest_sack_seq(), the we use
skb=3Dtcp_highest_sack() as a hint to speed up the lookup(avoid to
lookup the tree).
so we can see that the skb->seq <=3Dstart_seq.
then if we use the skb and start_seq to call tcp_sacktag_skip(),
the tcp_sacktag_skip will go for rtx tree lookup, so
code snippet does not take effect.

static int
tcp_sacktag_write_queue(struct sock *sk, const struct sk_buff *ack_skb,
u32 prior_snd_una, struct tcp_sacktag_state *state)
{
...
while (i < used_sacks) {

if (!before(start_seq, tcp_highest_sack_seq(tp))) {
skb =3D tcp_highest_sack(sk);
if (!skb)
break;
}
skb =3D tcp_sacktag_skip(skb, sk, start_seq);

walk:
skb =3D tcp_sacktag_walk(skb, sk, next_dup, state,
start_seq, end_seq, dup_sack);

advance_sp:
i++;
}

3) on the other side, let me show the logic in tcp_sacktag_bsearch, the log=
ic is
   the skb->seq should be met:
   seq=3D<skb->seq and seq<skb->end_seq
so the seq should be included in skb, the log is not consist with
tcp_sacktag_skip().

static struct sk_buff *tcp_sacktag_bsearch(struct sock *sk, u32 seq)
{
struct rb_node *parent, **p =3D &sk->tcp_rtx_queue.rb_node;
struct sk_buff *skb;

while (*p) {
parent =3D *p;
skb =3D rb_to_skb(parent);
if (before(seq, TCP_SKB_CB(skb)->seq)) {
p =3D &parent->rb_left;
continue;
}
//[Xin Guo] at here seq=3D<skb->seq
if (!before(seq, TCP_SKB_CB(skb)->end_seq)) {
p =3D &parent->rb_right;
continue;
}
//[Xin Guo]at here seq<skb->end_seq
return skb;
}
return NULL;
}

i hope that it is more clear now, thanks.

Regards
Guo Xin.

On Thu, Jul 17, 2025 at 4:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/13/25 5:22 PM, Xin Guo wrote:
> > tcp_sacktag_skip() directly return the input skb only
> > if TCP_SKB_CB(skb)->seq>skip_to_seq,
> > this is not right, and  the logic should be
> > TCP_SKB_CB(skb)->seq>=3Dskip_to_seq,
>
> Adding Kuniyuki
>
> I'm not sure this statement is actually true. A more clear (and slightly
> more descriptive) commit message could help better understanding the
> issue. What is the bad behaviour you are observing?
>
> Ideally a packetdrill test case to demonstrate it would help
sorry that a packetdrill script cannot show the wrong behavior.

>
> > for example
> > if start_seq is equal to tcp_highest_sack_seq() ,
> > the start_seq is equal to seq of skb which is from
> > tcp_highest_sack().
> > and on the other side ,when
> > tcp_highest_sack_seq() < start_seq in
> > tcp_sacktag_write_queue(),
> > the skb is from tcp_highest_sack() will be ignored
> > in tcp_sacktag_skip(), so clean the logic also.
> >
> > Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
>
> At very least the fixes tag looks wrong, because AFAICS such change did
> not modify the behaviour tcp_sacktag_skip.
the commit 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
change the tcp_sacktag_skip(), and not be changed till now.
so i think it is right.
>
> > Signed-off-by: Xin Guo <guoxin0309@gmail.com>
>
> Thanks,
>
> Paolo
>

