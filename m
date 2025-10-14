Return-Path: <netdev+bounces-229192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C937BD90F3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86CE3BAC44
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C72FE053;
	Tue, 14 Oct 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jX+0Belh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4F1F239B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441707; cv=none; b=c05LSi76x8cWcRF4tuwH5Qnc9OIxltC7yPdLfrT+EFpp/igCyAMhdEkHCaQ8k+aRAFTAwKuw/rj4g60ah4iXC1M+Uj3r3TDuyMySxXP3LziBS5E/vVkz/jECRsIpNCk7Bgku7MkSKtSqkA3cnzUcyIr6ylp0xK2HSAnSNaGZ0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441707; c=relaxed/simple;
	bh=T3t0+cYCuL3VKAnxS7+KPj15eJ+4z2KvH9LNLJxNSNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuxsCMliaI/sshPHd161/7RUljaUQ7ODBoi55KAcIGsYTUgqI/eGLfyAvehZX+6BAQrM5spUbcj8SFn9lq+PewwnF6dsF1uEoQt/V5JzrG/8P5sFWwS32zGTEbXkpnwooxwNWs9f5xICjTnC5SOiLX7BDKB3xG298vIvaH6KNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jX+0Belh; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-791fd6bffbaso81442586d6.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760441704; x=1761046504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVR3/U6+ocxlCfncD6DTY1Wi6NUabWM18tL8EPxbc4Y=;
        b=jX+0BelhB8lxTjS2WHUN00H1b5qUxNC1UR5HsXAvRrWLBSOfI9Y9yjfqw0JaHoFY7P
         EHNhUexNSLw58+60kIx9JvUJz8PCPobaNnlAvdTilfSgLsznbtRhnsJDtCFzSN7llCS7
         2Ms5qLGRPuL5pHhX2VfKLjA4WBFLR5Mz9JXArSVKnkstfuSLA2Vb6IcIZCmU8gBiHggf
         Z3+oqfDcFGpBk6rvfpBbtES0FrGn4sj2qe+Kse1Phow8a3AjZ6sJCMUqIPJWIRvqr+e/
         ceErRjXozyEUeODKJ25Q5DEt+a2QBMAyt/dXkGjq4Ma3/P0e9cFEsTJE/JvJWFUrfzrW
         hj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441704; x=1761046504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVR3/U6+ocxlCfncD6DTY1Wi6NUabWM18tL8EPxbc4Y=;
        b=i9mmlYv3yBXSHJ4sgA4upryGMf+AYlp61YQMbXi1L920herf/Oj6zOIVCtDjxtQXCy
         5LqC8F+2pQEAguUjq61gsuYlNIGAC832vtJt34XwbHEn723IGhTgxdvYwamNvwOr9xTy
         kQ7cxV3uqDIPx7SPb5AgOOqegnz4D/WL0Dm/J4YY2+XBZuJCPr6cYCgHD1qsVyegQTto
         Y2a8iNktPbvqE26SirBr1++rlJl+f0jpjZLWW33ZmYOkbQjMuhJQJO5+hz0OJk7DqLSB
         9GMZVFW7jVDHSpwGEwfiEwyAxz3AiEwrYEDuu3//wxsTd06A2+G2KixR9+LwJTc40kfT
         Z05Q==
X-Forwarded-Encrypted: i=1; AJvYcCVziaGagH//fHfDeFyTfBldpXR3LsgLYeTxK9rm0CbZpDjlHDYjDXQOvzav+q6xKnff5gKiasU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0FLyyhV6vkkwMl6JXBavbWVTijESHsiZwl8KhNxdBu9+XOgU
	SXMFS7lFiHJSL310/RLPoOBl06hSPQnaMMQybVmN5gu9bcgw0uuCzpBxTV57WCYAKtf7Du2XMmg
	aeMUlkAITCDYcu2BDUdrwx9PnEuZj8cF5Ql7pUmBT
X-Gm-Gg: ASbGncvldNJnbL8gCu9vsVhOwN1R0PCCJC1VK5S8gerZuxV10tD9SDkRvAAIDqsBkJ7
	CfulL/V6WUvclibJOuigOMwoK8l9x76SqOfCaNn+czn7ZBQlYAgWrp6r1mE3nOwCy/zlQ71lmjq
	W8cUwsycvK0wYMtI/h0Kx7kzVuABCi6e1r80QkFsQ413NCNYZCKx7DH0F5qM8Xg1w0dnX7ZGF2N
	HMst8I/xYCv2a+2hc61rpBIRuiNGWTHhTjXlLbNPzM=
X-Google-Smtp-Source: AGHT+IErcRymCqmHzYzspQCDTX2dPgmRiGtPAAIxOL8F0bRuGV7TpK34yxFU37vdJGxxLCf7JJaaqFOhRNfZu9x3EEM=
X-Received: by 2002:a05:622a:250d:b0:4b5:e9e3:3c90 with SMTP id
 d75a77b69052e-4e6eacceb54mr399056251cf.9.1760441704251; Tue, 14 Oct 2025
 04:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com> <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
 <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com> <tdxplao4k3tru2ydqrjg5wzt4mmllblmilys456y7latayvdex@3l7xabhdjf2d>
In-Reply-To: <tdxplao4k3tru2ydqrjg5wzt4mmllblmilys456y7latayvdex@3l7xabhdjf2d>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 04:34:52 -0700
X-Gm-Features: AS18NWAmZCgDyqvKRL6Rox3zhzKYp8P6DV9AS8hTvm7VAVuJ3moVlXts4gNWtVs
Message-ID: <CANn89iKQYN1qTZoSW4+1v6scDgH53zi9pP_O_mEbTdYQYie1uQ@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:20=E2=80=AFAM Michal Kubecek <mkubecek@suse.cz> w=
rote:
>
> On Tue, Oct 14, 2025 at 01:27:13AM GMT, Eric Dumazet wrote:
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 95241093b7f0..932c21838b9b 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
> > sk_buff *skb, int len)
> >                 sk_peek_offset_bwd(sk, len);
> >
> >         if (!skb_shared(skb)) {
> > -               if (unlikely(udp_skb_has_head_state(skb)))
> > -                       skb_release_head_state(skb);
> > +               if (unlikely(udp_skb_has_head_state(skb))) {
> > +                       /* Make sure that skb_release_head_state()
> > will have nothing to do. */
> > +                       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> > +                       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> > +                       DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> > +                       skb_ext_reset(skb);
> > +               }
> >                 skb_attempt_defer_free(skb);
> >                 return;
> >         }
>
> Tested this version on my system (with DEBUG_NET enabled) and everything
> seems to work fine so far.
>
> Tested-by: Michal Kubecek <mkubecek@suse.cz>

Thanks for testing. I will follow Sabrina suggestion and send :

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..d66f273f9070 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
sk_buff *skb, int len)
                sk_peek_offset_bwd(sk, len);

        if (!skb_shared(skb)) {
-               if (unlikely(udp_skb_has_head_state(skb)))
-                       skb_release_head_state(skb);
+               /* Make sure that this skb has no dst, destructor
+                * or conntracking parts, because it might stay
+                * in a remote cpu list for a very long time.
+                */
+               DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+               DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+               DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
                skb_attempt_defer_free(skb);
                return;
        }

