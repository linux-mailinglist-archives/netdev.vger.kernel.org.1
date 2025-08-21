Return-Path: <netdev+bounces-215606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBCB2F7D7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24406042EF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FB2E11D7;
	Thu, 21 Aug 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jy56pvHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76E16F265
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778946; cv=none; b=iUlzk/y7Gl/GcLdX9S+pUjdHy/t694iJQS4evO5MFVw7/L7ngOy0+yk7XR/6IxfazrsrdOe9q8YYVFqy35icS+ISN8X7DmKAATk52YPxGU2foYlIXgGkFn/R+irBRZp3WdaZ5RrXpr/YVOvIiCJlKU2ZSlRKyBHZ1dECQ8gq4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778946; c=relaxed/simple;
	bh=fSEsQ/Vk6OMQpZkWmTwVJ6fm0yCcKERCKkZiq1OYf8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz7+wIu8DTXJb8zpAPqobW9IVaNNkQRmygK/3Oq5ZBrjgP0e/Gdq5+C36JzTHkngO7QzBg7kdgXUfyLcftdsvpZHMB5JaYWQ5tbEcB577m9jRqsMLE3P2J1vFAm/xo19CSAwwLgsvAZcecNN188iUjQT+d2Vrzg9ZCb/3BNZW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jy56pvHo; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109c482c8so15428601cf.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755778943; x=1756383743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKSsjvve/1RAj60Dban8ij17MQ++dGwNHw+gQ1QKQpM=;
        b=Jy56pvHopgVB4QlSdjncvHSNwKJIyH1Jqn/VU5MfuBNlaMxR6MMS7f7be0iKp1yM7c
         T6Ls3h8VJB4p01WMuTKeD6HeNMThCfAMaA2ivjdV6j8t/BGNexZq3mnxToSNjuH7GTI4
         SeLLsuPpAtVImwsQjvgfTndynLEWkirbKbaumcFNAm3SyDyx/XiED9J7Tz7rjV2ZUW+b
         v99L+FAGWOeWKJCBJV3SaoPXXlhVhMeId6KlRjikRNNrp/CIt/k3tQtwPQDh9L+paFCu
         EwvrZ30mwznm7mMpk64rcAnch23ynjVuKA8/9SVMMA8HX9MJ3FMbE9NQ2HVfvvcMvuSn
         3qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778943; x=1756383743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKSsjvve/1RAj60Dban8ij17MQ++dGwNHw+gQ1QKQpM=;
        b=XAgA62SC0XQ1gh5Zm3/ZswcVkiNQ9MdK6y5WPccmQ5GX21JYgWF7sEkQQ8sWc7nRZl
         ame9nZ60q4Zm014vnta1qLyKzohM+7ls4uoxnOCm/Bg2FeRxkXpWKZLNAdXEGBlFT86E
         3wONGbKUj5//mwrv8mlt+/zvV8TWKdU93x5HMFs/ev/eVCGVUAJHkPY8CFZbOXBg4Xqd
         65MOKmYYBnnP2GJQUh3FLKzGZbCGaYn8cMnjfNnC7VbqFm5y0J1OA9j0hjGz2PhLZojU
         sqbEnixUk2pPoSOZLKTZMDmWagpz2kKAyFIjNQbDy85bT9mldE/RQ/q9FvK7DXJ3vE4g
         gN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXKuRIU4H/SWLWnmRYxIw24q7ARLVgFg/snflAw+fPOQlWqwCwe+/qo/YGrSfNeGrhIhtb3t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTdpZuMtd0nhjM/9LNDUIhrHX9rBUruciD2nQfzw2VrFPPhOzX
	Mdgjx5KyHws6Pcee64qaDIlzfwmz6hOmRm5svYw4luEScYrUYv3taUAYlWd1lCMiBJXY+oQTWUa
	5jtOjKv9+8BuIqbD8puLgrOacXqqYbOxgfv7DmS8Z
X-Gm-Gg: ASbGncu44nK55VxU3N67PJyplfXJYJ1vGZ0YnN04BHu40iE9lGfTigwAdruJN+VImUG
	uwpmvA7SMnhAiCe2T+enT/is8yXlP/rE/lbFjTCdGNTQWRp5r7jc3z06FJ+BDd8XNVZZTGe7KRN
	VQHOzScnGJva5sOCA/80GmylOlYm8AeuqhoiAdjCy33+XXNsyz4uP1I+I/UFbLomCtWWzgMf0ny
	bEI67gljdiTqiZD3GvibYfSRg==
X-Google-Smtp-Source: AGHT+IFXwsqHTBSwwL4QWrFjnAqYGYGRHHfnn0fyyJIeQ/rD+n3E/hb0G9BvZiYOX886SM/9LiSsdHBY2287j79joNs=
X-Received: by 2002:a05:622a:191c:b0:4b2:9620:33b3 with SMTP id
 d75a77b69052e-4b29fa5cbfcmr20179561cf.34.1755778942207; Thu, 21 Aug 2025
 05:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-7-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-7-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:22:10 -0700
X-Gm-Features: Ac12FXwJLwuIZZV7IiiWgI7Ni_b_-fkA-MWf7lHGDVGOEcjIPXX_K_j__DXPqFs
Message-ID: <CANn89iKAUB4JOoHDPrxsRDeBTXPEF8Fu4ab2O_w2QTnRNXJvzg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 06/14] tcp: accecn: AccECN negotiation
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, 
	Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Accurate ECN negotiation parts based on the specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Accurate ECN is negotiated using ECE, CWR and AE flags in the
> TCP header. TCP falls back into using RFC3168 ECN if one of the
> ends supports only RFC3168-style ECN.
>
> The AccECN negotiation includes reflecting IP ECN field value
> seen in SYN and SYNACK back using the same bits as negotiation
> to allow responding to SYN CE marks and to detect ECN field
> mangling. CE marks should not occur currently because SYN=3D1
> segments are sent with Non-ECT in IP ECN field (but proposal
> exists to remove this restriction).
>
> Reflecting SYN IP ECN field in SYNACK is relatively simple.
> Reflecting SYNACK IP ECN field in the final/third ACK of
> the handshake is more challenging. Linux TCP code is not well
> prepared for using the final/third ACK a signalling channel
> which makes things somewhat complicated here.
>
> tcp_ecn sysctl can be used to select the highest ECN variant
> (Accurate ECN, ECN, No ECN) that is attemped to be negotiated and
> requested for incoming connection and outgoing connection:
> TCP_ECN_IN_NOECN_OUT_NOECN, TCP_ECN_IN_ECN_OUT_ECN,
> TCP_ECN_IN_ECN_OUT_NOECN, TCP_ECN_IN_ACCECN_OUT_ACCECN,
> TCP_ECN_IN_ACCECN_OUT_ECN, and TCP_ECN_IN_ACCECN_OUT_NOECN.
>
> After this patch, the size of tcp_request_sock remains unchanged
> and no new holes are added. Below are the pahole outcomes before
> and after this patch:
>
>

> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>


> +       if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
> +               TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_ACE;
> +               TCP_SKB_CB(skb)->tcp_flags |=3D
> +                       tcp_accecn_reflector_flags(tp->syn_ect_rcv);
> +               tp->syn_ect_snt =3D inet_sk(sk)->tos & INET_ECN_MASK;
> +       }
>  }
>
>  /* Packet ECN state for a SYN.  */
> @@ -125,8 +377,20 @@ static inline void tcp_ecn_send_syn(struct sock *sk,=
 struct sk_buff *skb)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         bool bpf_needs_ecn =3D tcp_bpf_ca_needs_ecn(sk);
> -       bool use_ecn =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn) =3D=
=3D 1 ||
> -               tcp_ca_needs_ecn(sk) || bpf_needs_ecn;
> +       bool use_ecn, use_accecn;
> +       u8 tcp_ecn =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
> +
> +       /* +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +        * | tcp_ecn values |    Outgoing connections   |
> +        * +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +        * |     0,2,5      |     Do not request ECN    |
> +        * |      1,4       |   Request ECN connection  |
> +        * |       3        | Request AccECN connection |
> +        * +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +        */

You have nice macros, maybe use them ?

      TCP_ECN_IN_NOECN_OUT_NOECN =3D 0,
       TCP_ECN_IN_ECN_OUT_ECN =3D 1,
       TCP_ECN_IN_ECN_OUT_NOECN =3D 2,
       TCP_ECN_IN_ACCECN_OUT_ACCECN =3D 3,
       TCP_ECN_IN_ACCECN_OUT_ECN =3D 4,
       TCP_ECN_IN_ACCECN_OUT_NOECN =3D 5,

This can be done later, no need to respin.

Reviewed-by: Eric Dumazet <edumazet@google.com>

