Return-Path: <netdev+bounces-219122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEBB40054
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB55E361E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D265D2C026B;
	Tue,  2 Sep 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vd1Tw94I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC652C11C9
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815435; cv=none; b=C0d+utmnHUGoouDz6WjxJtNA9D2Z8Js6hP1cSyffXdFAtH/vY5bM4aYrVzvU2LfYexP03tNOLFzNUEQy2q4b4nXv5lL/iy1yDCGIIlnoLT68n4fdCrFLK6afYeihqSSZ9bxT7TwVhQCf2t+mqEBkeSL/+FVxSqD+PLmxakOwcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815435; c=relaxed/simple;
	bh=9lvYvjz9oLH11C9SRrBllpQA4sN1VpxYrd5QpvhNzIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfKwgSPuF4kuoAeLo86oYo5pMRH7E5sYYYVu93VOubTC8EKtoPOwEmfP7pzwpEO4S8+DTdTUe39TjkTifeCSa5E7BG1XtaMeUv82wm/7JakwhYhuOWd9mm2LjbrTyYNwUsrWn6nv4gJwN5zJxQWAjwl9nwrS+uDtGLbwmSKcVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vd1Tw94I; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b2fd85d912so42611371cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756815432; x=1757420232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C8HhiAbmqyKZ07AQdc68LT41Jun2uFkYa8nCTGuq/o=;
        b=vd1Tw94I/Fwv7fen53Q9d/a7mHtgBeAwC/7kXAbmMvfZM3iIKWYQsRXiI3nkhzJPOL
         nN18A0IWDYPGmTxmO1fwp7LIbbWIQndL286TIHopABIIV1B5NsW1gZd0j6FcUZCHE4ed
         xm9h8zAwaECwiHp0JTfoc1Rt6rxIttsk/RjmUUAWdI5+MdV4/SVw4r3ePhtVPvpZ6TF7
         6GaHOMX4Et3D5Q7bHlI/QtqeaZhho0OtVE2ZdFupJXn4YpN6iIJ3G3aIsQo864wRA2Vh
         LpOrR3dha8um9VD/TiII68TSupUqQ4j9e/R16jDjioSx1p/PC0UvddilAUNdCIf3TgQs
         E0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815432; x=1757420232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C8HhiAbmqyKZ07AQdc68LT41Jun2uFkYa8nCTGuq/o=;
        b=gBmO5xl3LZVQUsid+GoKVoteWt9eoz5Uba30vasWsOXVmhgzSZRyduPnGwJzTRqBdv
         D1C331CqsHq5I/byerk00k3czh+g9ivWSW+IrP0ESo8o6n5OWYVmISmILfC3rRciIzJC
         CM60kOB9SOhNO743fkd9CpEMTxI1/T/v20TytdKmleMji2dW61PM6k6OjKrFAVgKwMKG
         8ByB4hsYWlaPoe4GM0JLDs7KjlaLGN4zKwKygHIkmuLhbmiH+YQLDfOTBAyR21rqbv/7
         dijcgfOgKMdRQl+9+3LfoAkARn8G6WR4acMbcpBQmfVFOy0oQpDofF8mcmsxnA2oGVUv
         m6ug==
X-Gm-Message-State: AOJu0YxaI+Ma7W+2d6m8LZ+LKz1mOKJgZPEhaY9KGiU0see1yu0w4sCb
	KzDOn/zrPcJrQwxzPbunrYjAtXLM8Pj1Y6ZTvC6U9f/5Q3tT1D+HaXuDn2fYld5esa4BlSznYy4
	Wa83+Ym8oOzk83o4ldpMZ3Yb4E6n0nziq4gPocOnMuVZbKiu97S2nbbf3I/Y=
X-Gm-Gg: ASbGnctfjFi9o+FcRXwKkWHPAPaRI1jxECKkodrCWZDvtub1wVaQ8SKmQWRaaOzZuvX
	CQg3HeDZrL2n5AQjeghK2pRQVVhygYc2R2bGag6yTQYGWRhv0/YeDVdGfazbiYOwYrJXNzV0ou7
	TskkcMxEBjcHdLqjvA0nzFFpcB1sIBYMWmzpIOMAmH3K0tt7WDBYimyGYKAHpwgFcJN4T6qcx18
	TtVUHdB5JoJOIrI0264YEwc
X-Google-Smtp-Source: AGHT+IHcH/H1lycWairKRpUbeZPheogsbTN1JCJuTc6h3m6S9ie+3aZYW8GLWtig1v6leXrG2Jq39MoWaTiWWD5BtW8=
X-Received: by 2002:a05:622a:4207:b0:4af:1535:6b53 with SMTP id
 d75a77b69052e-4b31da3b2a0mr111586411cf.54.1756815431443; Tue, 02 Sep 2025
 05:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902112652.26293-1-disclosure@aisle.com>
In-Reply-To: <20250902112652.26293-1-disclosure@aisle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 05:17:00 -0700
X-Gm-Features: Ac12FXwxvTv50lN1d0Pc3QGydNIau9Y-5gIPUQ2s5-Ch6CNmV8d6lKAss4kdnZI
Message-ID: <CANn89i+xUZ5R1jV8O8u6WpX1RDtgtdcfUHVGDrVZFuO7fuXrbg@mail.gmail.com>
Subject: Re: [PATCH net v2] netrom: fix out-of-bounds read in nr_rx_frame()
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, security@kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:27=E2=80=AFAM Stanislav Fort <stanislav.fort@aisle=
.com> wrote:
>
> Add early pskb_may_pull() validation in nr_rx_frame() to prevent
> out-of-bounds reads when processing malformed NET/ROM frames.
>
> The vulnerability occurs when nr_route_frame() accepts frames as
> short as NR_NETWORK_LEN (15 bytes) but nr_rx_frame() immediately
> accesses the 5-byte transport header at bytes 15-19 without validation.
> For CONNREQ frames, additional fields are accessed (window at byte 20,
> user address at bytes 21-27, optional BPQ timeout at bytes 35-36).
>
> Attack vector: External AX.25 I-frames with PID=3D0xCF (NET/ROM) can
> reach nr_route_frame() via the AX.25 protocol dispatch mechanism:
>   ax25_rcv() -> ax25_rx_iframe() -> ax25_protocol_function(0xCF)
>   -> nr_route_frame()
>
> For frames destined to local NET/ROM devices, nr_route_frame() calls
> nr_rx_frame() which immediately dereferences unvalidated offsets,
> causing out-of-bounds reads that can crash the kernel or leak memory.
>
> Fix by using pskb_may_pull() early to linearize the maximum required
> packet size (37 bytes) before any pointer assignments. This prevents
> use-after-free issues when pskb_may_pull() reallocates skb->head and
> ensures all subsequent accesses are within bounds.
>
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> ---
>  net/netrom/af_netrom.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index 3331669d8e33..3056229dcd20 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -883,7 +883,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_devi=
ce *dev)
>
>         /*
>          *      skb->data points to the netrom frame start
> +        *      Linearize the packet early to avoid use-after-free issues
> +        *      when pskb_may_pull() reallocates skb->head later
>          */
> +       if (!pskb_may_pull(skb, max(NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1=
 + AX25_ADDR_LEN, 37)))
> +               return 0;

I am not sure about the minimal packet length we expect from this point.

I was suggesting to use skb_linearize() here, but then add the needed
skb->len checks
of various sizes depending on the context (different places you had
patched earlier)

Thank you.

