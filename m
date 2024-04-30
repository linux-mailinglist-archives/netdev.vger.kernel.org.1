Return-Path: <netdev+bounces-92541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12C8B7C9A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B401F23E92
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B4175549;
	Tue, 30 Apr 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0DtPFPR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90F17554A
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493848; cv=none; b=beouSD2lg27VpGUNo2uiPEtTIf+iUXj0QREisL91G8f4KWfLz8UtLkhZkuTD5BgxPFazxlS96iPHqwS2kUk8QiHvfamZHCYVPyVt9vIjV93K9eYCzYJwGI0p49qwcqjKy9soUQisQz/3jPoa74qMshotD/cvtbpg4SFWSR8IUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493848; c=relaxed/simple;
	bh=LraMHHXJexRBUmE1VurNANOUEO48WRtFBWGyBVFbjow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkXxCfNVF34JxRxmX/TEIYXqdCvuxPIZ2pSppxLgiTKJ7eXXKBgnQnn/2gLMbm5ju5QzhmjQyD6w9yJzPxho2CBUs7qhL6zWgOmUmnSHd8Bg7PEFodIvjqS0Zz8iyTv1s19ESxrS90r1owfnHRrVbYX5lxmA0gMNBK4Nb7ZhxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0DtPFPR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so19605a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714493845; x=1715098645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y2yaLrjizI/E7+QoCpiUksG1NRgVzp6GL1mOLadyuw=;
        b=Q0DtPFPRGwPWtQI8P64KfqJZyIPk7wmNo0otTEnGVXZ824G7S3gznOpe5chChhfA/A
         ckerHK8rUXdkJ0CSJ+0YMpi18Uue+x7gls9zmFoMC+oYoJ19mDu1c3kWKPZvw5dusDLi
         wz87HXDJE+zSoA9vd9++V9jHFky3PbfbUPBtMj2TCmflRg8tnQd9Kps2r9GK8k+eSi7O
         sHVoYHSw2Q2PL5c0faZweYVnpN14AUEuYTfgenp5/bl/UWsBkPOhHtNr/jq0WPhg4rSG
         akcn4+cRFd1BqRaNzH3EAM5Fw3byMMJmECJ/dI43Ey2K/cEp/OMI9XBoS2FGwWb7hv29
         IRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714493845; x=1715098645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y2yaLrjizI/E7+QoCpiUksG1NRgVzp6GL1mOLadyuw=;
        b=i3tO7INR6ATMRDWmrlqhJxeRUK6lTjYyKellCu1IltapjLAHF1VxeXwE2AjWq01cRR
         kngrNZzeKQQ63lQ7GqMfEw3WkZXZ5ThU8qIlY+vP/cdpKigt8zksuYPGLXiHXYitQOuu
         zMg59qnZd5UmugKRJamXaSEVyJ6p4q2xNY0mAyaZu+wfHVE8eUGT62p4xIMONsRP1zAe
         /6LfEIui2o0LgBjZ/jj/KIoKIzqc4fCO5OQcu68N6F9T6Sao/5i1VFy5Lg7o7+jk/M7x
         EgHgmE/eJfWrPBZMZQX6v9RH/+5jBFQRDD3OWZT8TJPus5CLAzwdVcPIUE7vzpdHZA5L
         3ipw==
X-Forwarded-Encrypted: i=1; AJvYcCXtbJUOigpC9aenU4VWszYmnDqS7aVKlZJqcwZ2GS5X0u4QAgQFJIECXSfqxQ8OHricwz94mMUdSDVPVAgsTMGK4nI+2JBm
X-Gm-Message-State: AOJu0YyhpGs7cplWuhKXpBMgmVpuIhm3vMS/qVyj3eGil6w6G/8ls0vh
	kNFy54rnHDSYg4EliCMCmpxZ2hpM/8Y89z/FhCAV7bTlIAkVxJJi4b5fzMcfJAWiRIXEeZERJVS
	VkzyRBZmiHqful/YI1irs74TyOKng4iEkBzX3
X-Google-Smtp-Source: AGHT+IESU/dM6bmUJHhsZuFMldZvd/0hvPQeOKCaupEW5EKIhrkDWKnIVGQ+X5UtN6WFUU3eiNTaiDTZpR3WH0Q+gq4=
X-Received: by 2002:a05:6402:174c:b0:572:7d63:d7ee with SMTP id
 v12-20020a056402174c00b005727d63d7eemr217656edx.4.1714493844670; Tue, 30 Apr
 2024 09:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430143555.126083-1-richardbgobert@gmail.com> <20240430143555.126083-2-richardbgobert@gmail.com>
In-Reply-To: <20240430143555.126083-2-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 18:17:10 +0200
Message-ID: <CANn89i+rCK4jmjRUXywpeQeE1PPjNF=kf1_kEOB+UTYzi3MkYw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net: gro: fix udp bad offset in socket lookup
 by adding {inner_}network_offset to napi_gro_cb
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com, alobakin@pm.me, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:40=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("ud=
p:
> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in th=
e
> complete phase of gro. The functions always return skb->network_header,
> which in the case of encapsulated packets at the gro complete phase, is
> always set to the innermost L3 of the packet. That means that calling
> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer=
_
> L3/L4 may return an unexpected value.
>
> This incorrect usage leads to a bug in GRO's UDP socket lookup.
> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> *_hdr functions return network_header which will point to the innermost L=
3,
> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> encapsulated packets.
>
> This patch adds network_offset and inner_network_offset to napi_gro_cb, a=
nd
> makes sure both are set correctly.
>
> To fix the issue, network_offsets union is used inside napi_gro_cb, in
> which both the outer and the inner network offsets are saved.
>
> Reproduction example:
>
> Endpoint configuration example (fou + local address bind)
>
>     # ip fou add port 6666 ipproto 4
>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap =
fou encap-dport 5555 encap-sport 6666 mode ipip
>     # ip link set tun1 up
>     # ip a add 1.1.1.2/24 dev tun1
>
> Netperf TCP_STREAM result on net-next before patch is applied:
>
> net-next main, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.28        2.37
>
> net-next main, GRO disabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.01     2745.06
>
> patch applied, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.01     2877.38
>
> Fixes: 57c67ff4bd92 ("udp: additional GRO support")

Nit: I would think the bug was added later in
a6024562ffd7 ("udp: Add GRO functions to UDP socket")

> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

