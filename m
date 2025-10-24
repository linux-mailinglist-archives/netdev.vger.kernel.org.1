Return-Path: <netdev+bounces-232652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39049C07B5C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DDD3A2D16
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B9A253F05;
	Fri, 24 Oct 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1kkGTUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BE231832
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329839; cv=none; b=XbkdzMQ18oINTEfjD1Gm8x+/aYm8By7Zpiatg0Cy4wVzmrSJBqmaF+n0T8055y5US9Ok0KQIR/PMuX8s2/wNtRb0EbMrj/k+q5Qr7vwXz3mVDjh2DoEPGNB2wyLy6zJwLv2BWf9BPchIm6W8STlMXq0XMKk2YcYQYCdaVqLB4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329839; c=relaxed/simple;
	bh=DrTetYwXYnChgeufrcDQ2X9huG25jnVcdcsflx4+eh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfPKZM1pon1qpVERE8LF5dM/rgelkpwApY6rwRMNQkr/+FYNjQcipJG2QlDyf1zPiRNB7bqxD8S3j4D3SpbJRtq75TsKe/kpKCMCcvxLjwAI+ox/FSJPlgJ1jvQwcTBTVWgcBffs547WNYG5mfdRJhuXFaHFGnDUW4sbNSQdcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1kkGTUn; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e35e48a27so2381085d50.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761329837; x=1761934637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h/ElMh0No0vgq96kFlbqzJt3eEKJ2285EnfEz82Ydg=;
        b=J1kkGTUnTXpQ74o8T0Q1lGWtOP0oUF1WJhYxYZrSnxuKYXpWE03zauZ3w+BK4lCUPU
         L7XoURzZ3JH2qYsUZTIxhZg2n7gbFMQLKibqpLOUNiGM11nEB0I2ijM3dPD/azWlEkJd
         w5HhQsiQ+yoE6xGdjFWGoLRo7nnEHvatmBN0gxF8IMYgxitM6FYieKCQdBfsjX/S26y4
         FXh/EykkV1ZyhCeH8CGpUi7nlfVknEivViteRhR/gSHgVFvjVUMoD+LeiRQEFr2dPoZt
         LFCUqMs5+1xKgSxgjuVUi/3JKBVRFQuVFsCTPZR5AWFQ0ksC9YCyI3WnXTNBga3meGbA
         Oxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329837; x=1761934637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2h/ElMh0No0vgq96kFlbqzJt3eEKJ2285EnfEz82Ydg=;
        b=ftTcJtQyQ+KKGY46nOR7IIz8VscAG3CdrJYA9XZum78M1TKmmdE+tunljHLSz4DiYW
         RqdkNOr4U5k/0xmDHx5BFeScJK+ZLF9J1eJQYAb5Gg6NSZterO1hA0482Hdfl+DDhoZ0
         86CFEQ8TTWjXhX0Yt4wSY9iPA+odbwjDgAodRMDyjYeQFFWhOtI3WKc9QpeoL+3t1A07
         cnEMUpmttHzWn6U3UYvXtKvlOmSFinN0o0CQpaNJamrCwBRLyhI9GyXVv84t2tfOdH6/
         cObS4/WIzNHbwgYwrBtbmNb6wgvGEJhr59jMLDycXCOkALIqV4bEhVfklLy3GQmaoe4Y
         1gUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt7ScsCebq3Xwe+PlbMKOnCyB0tFEBX47l20rParpOvTP6qdKLFcLWu4Ill9v/QgYNWu2Jyac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXN28V8CnDgSrrntMhDICweUp0nOMANnmaisUYVsezUj1XpJ1h
	NZXwCbEV1y/COKeaEjPdmdTdHxf+AsqJjHtANw0MoM9vKS2kp2cmIHihhKAkq17AcdWHLoUCUCx
	uvfWlT/NLS/NcwnYb18INjuXJX5DtO9LI9sL5f9Cf
X-Gm-Gg: ASbGnct4Lj6N4VbspSmHMPmPntU/vw6A0FoZf8pjOCsNz+osBcH36oLUiv2NFFQClox
	mtfzl7il8IxlVSxK4FcNripqB3J53zEddiRGp9gmyUxyfTRYdxiXNWa3M+6mXqbGHpAYmMmTGxA
	PJdyxLYLEqkRhZiPin8Ujk4xkD8o+JwzCKCTuhXHyBP6ffUHXoGsvPotUqbIgXrHn7CD4IgmjE9
	AFUG8nI68JXCukskRt0tu1oo3PRQoxfJoMnq9jldcdVqbxhZx8hy8sG2OP2xpS10ogE0viL7Pts
	IUYi3/FFnkaOoXzSfNhhF2GBxboSQj+g44D9
X-Google-Smtp-Source: AGHT+IH7fLaxmQPiHVCyIFuVlkCG7QU1A/wthZwwqQkRRKGlnH5+qz2v1xZpkL3rChyG1ByYzAe4TaJtZZ5aJ7l0xXQ=
X-Received: by 2002:a05:690e:1243:b0:63e:2a71:83b9 with SMTP id
 956f58d0204a3-63e2a7189f5mr17754554d50.65.1761329836370; Fri, 24 Oct 2025
 11:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251022182301.1005777-3-joshwash@google.com>
 <20251023171445.2d470bb3@kernel.org>
In-Reply-To: <20251023171445.2d470bb3@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Fri, 24 Oct 2025 11:17:04 -0700
X-Gm-Features: AWmQ_bkOcEz5vk4of_aFjLMcVnCbAUnvZuNnSpX91lCMUqEeQToL2-tc3L6UKxI
Message-ID: <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 22 Oct 2025 11:22:24 -0700 Joshua Washington wrote:
> > +     if (priv->rx_cfg.packet_buffer_size !=3D SZ_2K) {
> > +             netdev_warn(dev,
> > +                         "XDP is not supported for Rx buf len %d. Set =
Rx buf len to %d before using XDP.\n",
> > +                         priv->rx_cfg.packet_buffer_size, SZ_2K);
> > +             return -EOPNOTSUPP;
> > +     }
>
> Please plumb extack thru to here. It's inside struct netdev_bpf
>

Using extack just for this log will make it inconsistent with other
logs in this method. Would it be okay if I send a fast follow patch to
use exstack in this method and others?

> >       max_xdp_mtu =3D priv->rx_cfg.packet_buffer_size - sizeof(struct e=
thhdr);
> >       if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT)
> >               max_xdp_mtu -=3D GVE_RX_PAD;
> > @@ -2050,6 +2057,44 @@ bool gve_header_split_supported(const struct gve=
_priv *priv)
> >               priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT && !priv->xd=
p_prog;
> >  }
> >
> > +int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
> > +                           struct netlink_ext_ack *extack,
> > +                           struct gve_rx_alloc_rings_cfg *rx_alloc_cfg=
)
> > +{
> > +     u32 old_rx_buf_len =3D rx_alloc_cfg->packet_buffer_size;
> > +
> > +     if (rx_buf_len =3D=3D old_rx_buf_len)
> > +             return 0;
> > +
> > +     if (!gve_is_dqo(priv)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Modifying Rx buf len is only supporte=
d with DQO format");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (priv->xdp_prog && rx_buf_len !=3D SZ_2K) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Rx buf len can only be 2048 when XDP =
is on");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (rx_buf_len > priv->max_rx_buffer_size) {
>
> This check looks kinda pointless given the check right below against
> the exact sizes?
>

My intent was to code defensively against device accidently advertising
anything in [2k+1,4k) as max buffer size. I will remove this check.

> > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > +                                    "Rx buf len exceeds the max suppor=
ted value of %u",
> > +                                    priv->max_rx_buffer_size);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (rx_buf_len !=3D SZ_2K && rx_buf_len !=3D SZ_4K) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Rx buf len can only be 2048 or 4096")=
;
> > +             return -EINVAL;
> > +     }
> > +     rx_alloc_cfg->packet_buffer_size =3D rx_buf_len;
> > +
> > +     return 0;
> > +}

