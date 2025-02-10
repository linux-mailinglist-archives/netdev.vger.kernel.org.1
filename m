Return-Path: <netdev+bounces-164813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D511A2F3C2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F531668FC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1D1F4623;
	Mon, 10 Feb 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mw3GSmFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D231F4615
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205459; cv=none; b=i6f6yTzy3w9vjcD8Br9fR/TKsfxkVlljZyP1KJdfOOp4B+bjIgUnuy7jg7fDgJvnilB5g0l0/AHFlb3D//VJqEClWmHOVpHoWKCPu5TbQ9T0o6smPyQ66NVtG0g8SF5ndfGDEvSFKXlZgCfUgHzYjLzSL2wVyFYqzsNVTKr+mRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205459; c=relaxed/simple;
	bh=cFPIE/IHNfSJMp8eaDke84MJ4l2uOFWFQ+pr9OgUbnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvli0bNSXt+Hd2VvZlrt11NG8/p/Rmm8FZAn43ADCMHbXw0g9cRu6c6xEIQhg583lF1VB2/eHuQj5AGEN9JS8J/HuPNCxEhpOV/ogBcCYtLg5uNqunV5dzZ2BYDvbNdApt+Aj46xLSGHCqfHZeUXTbGiFF1EcgCtLcZQY6M6014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mw3GSmFT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de4d4adac9so6114019a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739205456; x=1739810256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYrIuoyjtjNQIX875qE9mesRmfzOJJPx+rhecC6ioc0=;
        b=mw3GSmFT9tNQXE0brusMjkwaXdONMuzq7/s14g8tovJOU6lMQPr0SW5gT+OEFjivxF
         eGGb0mBZ9qUOEY6TalstCs3P9aj8ULrZsMiZ/ueusLeW96JMQA3yqMyx/dF3IEQKIx62
         3RziYJ3G0zCb9DSoEdJzmRB+Uc/1uzANfxQnWwjS4uMAqjCMR7ZldUbQ7vS16LpGaQBl
         gDlV5AgcOoObLqC89EEObeZEl1kPGPlDcDaiQUmvBS/9ff2JsnR2ept4Txf7iksuZXFs
         xIEwVH5XmjM+Cagp54xjBnN2vbKE6CoiILkk4cvwirOpHBVssHAJDEGUPLhjP5Ue1uk/
         80JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739205456; x=1739810256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYrIuoyjtjNQIX875qE9mesRmfzOJJPx+rhecC6ioc0=;
        b=CtMUBDmN5/+xBqZjPhrlHf3iUc6ywlE+OcvYMo+1pxkIuNwzn6q0I6aZN3TlnP89+U
         xKwYzYAEWAow5Yq1Kfm0Pyfl2qbLgjTzqd2vaILFHKaMYfZi013otqc5skXXw2SlduBn
         PvwoykYdp+riSzjrMMpeXhx6BjaxMiB5h0qvtgvr5/LeFDTZ4mgoi9t8hB6Qtj5xQRPh
         EFzC4x2+tO7UB9DnYnpKXeiQtTwxecunRdN5EsmeD5ubkNmFIHIGil57jA53461Qo9dq
         CL0xt0qsxjE91wNNNkqgnM51rwL/+r+VdG5FLP18VJWPumVcRLThCWdsyZPalPOwB2S1
         sy2A==
X-Forwarded-Encrypted: i=1; AJvYcCU2rDo3wYKkRLLF9eTwflWG6MI0PSDc6782cXaaN3jR4A+tsbd68EOl/rVsDjGWG4TEnuGTwRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOidq05cNFCOA23uMc5ZyA3PX4z/FruSztuSsccxm94ldxJXtV
	oup/fRpFHiq3WWupEv+q4P07n9tIObM/iy+eTC2ffQMB3vu1hoP5zVK/oz84Nq8BUP1obJ4bnRy
	HU5chCfgHP7+fG8vCNgU6A9nOonKiqW9rMnzX
X-Gm-Gg: ASbGnculXkodaaunMGtyzJ5uk04AhVCvznCm92NMfM8EQbSx6938W08dqSrXEdrCjqZ
	IE7y0wue6WInDkDFlW/Xev1/4JcPXwIg+LIephZOtPeE5RSXjLS4IwHNrI+UsqtoVzmF9qYyc
X-Google-Smtp-Source: AGHT+IFuMNVtcCB+bnK73luYMquy1Y0f5y2HlvnCa2qekWGb/iSAWuX+mDH8PpPohDvsrogzwsnoeDycyiEUJENRwhA=
X-Received: by 2002:a05:6402:360d:b0:5de:5864:6628 with SMTP id
 4fb4d7f45d1cf-5de586466d5mr10097484a12.26.1739205455594; Mon, 10 Feb 2025
 08:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738940816.git.pabeni@redhat.com> <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com> <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
In-Reply-To: <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 17:37:24 +0100
X-Gm-Features: AWEUYZnJaoWbtqF6leQP7kSrPth5NJkBseJk2hDW-ejlzyD445o4WYV_xpBmJEg
Message-ID: <CANn89iLaDEjuDAE-Bupi4iDjt4wa90NA8bRjH8_0qWOQpHJ98Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/10/25 4:13 PM, Eric Dumazet wrote:
> > On Mon, Feb 10, 2025 at 5:00=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> >>
> >> Paolo Abeni wrote:
> >>> While benchmarking the recently shared page frag revert, I observed a
> >>> lot of cache misses in the UDP RX path due to false sharing between t=
he
> >>> sk_tsflags and the sk_forward_alloc sk fields.
> >>>
> >>> Here comes a solution attempt for such a problem, inspired by commit
> >>> f796feabb9f5 ("udp: add local "peek offset enabled" flag").
> >>>
> >>> The first patch adds a new proto op allowing protocol specific operat=
ion
> >>> on tsflags updates, and the 2nd one leverages such operation to cache
> >>> the problematic field in a cache friendly manner.
> >>>
> >>> The need for a new operation is possibly suboptimal, hence the RFC ta=
g,
> >>> but I could not find other good solutions. I considered:
> >>> - moving the sk_tsflags just before 'sk_policy', in the 'sock_read_rx=
tx'
> >>>   group. It arguably belongs to such group, but the change would crea=
te
> >>>   a couple of holes, increasing the 'struct sock' size and would have
> >>>   side effects on other protocols
> >>> - moving the sk_tsflags just before 'sk_stamp'; similar to the above,
> >>>   would possibly reduce the side effects, as most of 'struct sock'
> >>>   layout will be unchanged. Could increase the number of cacheline
> >>>   accessed in the TX path.
> >>>
> >>> I opted for the present solution as it should minimize the side effec=
ts
> >>> to other protocols.
> >>
> >> The code looks solid at a high level to me.
> >>
> >> But if the issue can be adddressed by just moving a field, that is
> >> quite appealing. So have no reviewed closely yet.
> >>
> >
> > sk_tsflags has not been put in an optimal group, I would indeed move it=
,
> > even if this creates one hole.
> >
> > Holes tend to be used quite fast anyway with new fields.
> >
> > Perhaps sock_read_tx group would be the best location,
> > because tcp_recv_timestamp() is not called in the fast path.
>
> Just to wrap my head on the above reasoning: for UDP such a change could
> possibly increase the number of `struct sock` cache-line accessed in the
> RX path (the `sock_write_tx` group should not be touched otherwise) but
> that will not matter much, because we expect a low number of UDP sockets
> in the system, right?

Are you referring to UDP applications needing timestamps ?

Because sk_tsflags is mostly always used in TX

We have not seen this issue because 97dc7cd92ac67f6e05 ("ptp: Support
late timestamp determination")
was not in our kernels at that time.

Perhaps we could change netdev_get_tstamp() so that we read sk->sk_tsflags
only when really needed ?

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5429581f22995bff639e6962a317adbd0ce30cff..848b70fb116421bf02159a53524=
a0700b87e851a
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5103,18 +5103,6 @@ static inline void netdev_rx_csum_fault(struct
net_device *dev,
 void net_enable_timestamp(void);
 void net_disable_timestamp(void);

-static inline ktime_t netdev_get_tstamp(struct net_device *dev,
-                                       const struct
skb_shared_hwtstamps *hwtstamps,
-                                       bool cycles)
-{
-       const struct net_device_ops *ops =3D dev->netdev_ops;
-
-       if (ops->ndo_get_tstamp)
-               return ops->ndo_get_tstamp(dev, hwtstamps, cycles);
-
-       return hwtstamps->hwtstamp;
-}
-
 #ifndef CONFIG_PREEMPT_RT
 static inline void netdev_xmit_set_more(bool more)
 {
diff --git a/net/socket.c b/net/socket.c
index 262a28b59c7f0f760fd29e207f270e65150abec8..6dc52c72fccd22f25c6e90d68de=
491863dc23689
100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -799,9 +799,22 @@ static bool skb_is_swtx_tstamp(const struct
sk_buff *skb, int false_tstamp)
        return skb->tstamp && !false_tstamp && skb_is_err_queue(skb);
 }

+static ktime_t netdev_get_tstamp(struct net_device *dev,
+                                const struct skb_shared_hwtstamps *hwtstam=
ps,
+                                struct sock *sk)
+{
+       const struct net_device_ops *ops =3D dev->netdev_ops;
+
+       if (ops->ndo_get_tstamp) {
+               bool cycles =3D READ_ONCE(sk->sk_tsflags) &
SOF_TIMESTAMPING_BIND_PHC;
+
+               return ops->ndo_get_tstamp(dev, hwtstamps, cycles);
+       }
+       return hwtstamps->hwtstamp;
+}
+
 static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb,
int *if_index)
 {
-       bool cycles =3D READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_P=
HC;
        struct skb_shared_hwtstamps *shhwtstamps =3D skb_hwtstamps(skb);
        struct net_device *orig_dev;
        ktime_t hwtstamp;
@@ -810,7 +823,7 @@ static ktime_t get_timestamp(struct sock *sk,
struct sk_buff *skb, int *if_index
        orig_dev =3D dev_get_by_napi_id(skb_napi_id(skb));
        if (orig_dev) {
                *if_index =3D orig_dev->ifindex;
-               hwtstamp =3D netdev_get_tstamp(orig_dev, shhwtstamps, cycle=
s);
+               hwtstamp =3D netdev_get_tstamp(orig_dev, shhwtstamps, sk);
        } else {
                hwtstamp =3D shhwtstamps->hwtstamp;
        }


>
> Side note: FWIW I think we will have 2 holes, 4 bytes each, one after
> `sk_forward_alloc` and another one after `sk_mark`.
>
> I missed that explicit alignment of the `tcp_sock_write_tx` group; that
> will prevent the overall grow of `struct tcp_sock`, and will avoid bad
> side effects while changing the struct layout.
>
> I expect the change you propose would perform alike the RFC patches, but
> I'll try to do an explicit test later (and report here the results).
>
> Thanks,
>
> Paolo
>

