Return-Path: <netdev+bounces-142713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3E9C0127
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001EF283011
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F691D90B6;
	Thu,  7 Nov 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGOZ5BsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A51922D8
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971896; cv=none; b=L8n6T0uf4zjEtWtf7FBMa8o7F9NxLPaiIzDKWc/zmS/YuDOnahnBtmZC9FhJ54+kDmeNmfl1dqulCQF0E/Q8tOczGcikAj1M9xl7BLfTSaL1IxCpp6oauxwq/Odye6jyWiYA/awyW2i2bAemVk8cEfRaMpy4KTLtZuyOkncRXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971896; c=relaxed/simple;
	bh=D7GL1NgTV+D0l7+YcvQ9j4AfyLlOjnyYOF5SJ76ezKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX4+ndI0dzpHeOI7OSY0IiqDL4wgKgjEOun4kFNze4bWMi5KoSldRhoGdcStdAo5BlaCCnGT3+RCWejBtRNymBmlWJ1uTbnY2sk4ktlkLFWK5M+Se1bJ3h3pFH2ZpU/3yQxCRIFuP6ulBTdjnqV83yXdzzVDvQt1ftPcn4K46Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGOZ5BsG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso888352a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730971892; x=1731576692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY9Bs9CheoIKcEiez2KK/fp1f+KGYnlB2WveMhlPtkI=;
        b=LGOZ5BsGmSDE8/xPRKc86fNMNNwWpctbzVx26iIXqXfJNr9nkdDKYcfjXN5WjkGDxK
         ReGwjmlDfnUOmynCLT4xyiZoCSo6NA/Hqa8JHdX0XuU2jTPPmYbi8ZeBpQ+cfmGipdU1
         a2rM+bIwHF3kZw7WoIW0KfvFEoyyk67WiDSH57mxjdsJ1Vl9evZmLNFlBkIa3Ns4Tu/j
         DYiXPnLkfuxJCL1bAKVF5poLTAXo+HTIWdnncpDKJH4l4AyyJdXoQmJbGjFJiemNqQ4Q
         wW4HwifpVceCN4ffu86gb2UqRUbjR0SSG+yG6NS94Ul2jINTty+qGeYfLhHAA5mZDXJD
         C4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971892; x=1731576692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY9Bs9CheoIKcEiez2KK/fp1f+KGYnlB2WveMhlPtkI=;
        b=bYG7+3HOvlAo+nsj80qeB6eVa5qUO7Lk8f5VOuZBJvncwN2ACpjCbG0jHQspcQxlda
         QUrAYXuZaxTlGM1NUiv0XnrXmcLO4Ukgg6/s9mroH7fo1gGeaxwc1/tZO3LCE7+2S7pE
         PCoZr/p7gfRS1YJ9lZKUYLt3Yrrt+SrrAfedbWen8S9cPO6pHqS1xEG/cXZ2HlTKKlTJ
         7u+q2xj+8j/9WePfhIjtGNba7DrgIeEJ77cmpSy+Lio2HKNd3w2gcKwylagZRsWzCPM3
         aa6XV/MCwh3gMAJglcyCru9XRS/jeyWrd4zK4G3EbA2BppzEum+IRETnzRTzt3drWwqB
         7xgw==
X-Gm-Message-State: AOJu0YxTuUTBo8ygv+rukpuPtnIdnIWfms2I/zs+wUqGn7MItUSH4Kpl
	xDCUA8c4AX7s9G1mIFoa1F0n8JFsbmc77mjsrduL04MQ4O4ss7I1VJMCbYELdDl61zaaDpL3uxF
	apzxr95ay7fMoNrm/ot5T+tLK0x40DbY7vJTf
X-Google-Smtp-Source: AGHT+IEDS+Tc3LlV7nRe3WOMM74OY/0T4rwQLN58NS0Kp2ypqwVQ6IXzTsq/HiXvVUt1+E0/6Fe2UOoO8JN2rrSyD/E=
X-Received: by 2002:a05:6402:90e:b0:5c9:7f91:d049 with SMTP id
 4fb4d7f45d1cf-5cbbf89d331mr30411739a12.11.1730971892419; Thu, 07 Nov 2024
 01:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-2-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 10:31:21 +0100
Message-ID: <CANn89iLEC4Gwr1P8x3tpFVFObvB4nM5xt0F=nRBNe1hqYOLU9A@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 01/13] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> - Move tcp_count_delivered() earlier and split tcp_count_delivered_ce()
>   out of it
> - Move tcp_in_ack_event() later
> - While at it, remove the inline from tcp_in_ack_event() and let
>   the compiler to decide
>
> Accurate ECN's heuristics does not know if there is going
> to be ACE field based CE counter increase or not until after
> rtx queue has been processed. Only then the number of ACKed
> bytes/pkts is available. As CE or not affects presence of
> FLAG_ECE, that information for tcp_in_ack_event is not yet
> available in the old location of the call to tcp_in_ack_event().
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/ipv4/tcp_input.c | 56 +++++++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5bdf13ac26ef..fc52eab4fcc9 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -413,6 +413,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_so=
ck *tp, const struct tcphdr
>         return false;
>  }
>
> +static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
> +{
> +       tp->delivered_ce +=3D ecn_count;
> +}
> +
> +/* Updates the delivered and delivered_ce counts */
> +static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
> +                               bool ece_ack)
> +{
> +       tp->delivered +=3D delivered;
> +       if (ece_ack)
> +               tcp_count_delivered_ce(tp, delivered);
> +}
> +
>  /* Buffer size and advertised window tuning.
>   *
>   * 1. Tuning sk->sk_sndbuf, when connection enters established state.
> @@ -1148,15 +1162,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_=
buff *skb)
>         }
>  }
>
> -/* Updates the delivered and delivered_ce counts */
> -static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
> -                               bool ece_ack)
> -{
> -       tp->delivered +=3D delivered;
> -       if (ece_ack)
> -               tp->delivered_ce +=3D delivered;
> -}
> -
>  /* This procedure tags the retransmission queue when SACKs arrive.
>   *
>   * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
> @@ -3856,12 +3861,23 @@ static void tcp_process_tlp_ack(struct sock *sk, =
u32 ack, int flag)
>         }
>  }
>
> -static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
> +static void tcp_in_ack_event(struct sock *sk, int flag)
>  {
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
>
> -       if (icsk->icsk_ca_ops->in_ack_event)
> -               icsk->icsk_ca_ops->in_ack_event(sk, flags);
> +       if (icsk->icsk_ca_ops->in_ack_event) {
> +               u32 ack_ev_flags =3D 0;
> +
> +               if (flag & FLAG_WIN_UPDATE)
> +                       ack_ev_flags |=3D CA_ACK_WIN_UPDATE;
> +               if (flag & FLAG_SLOWPATH) {
> +                       ack_ev_flags =3D CA_ACK_SLOWPATH;

This is removing the potential CA_ACK_WIN_UPDATE, I would suggest :

ack_ev_flags |=3D CA_ACK_SLOWPATH;


> +                       if (flag & FLAG_ECE)
> +                               ack_ev_flags |=3D CA_ACK_ECE;
> +               }
> +
> +               icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
> +       }
>  }
>
>

