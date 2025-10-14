Return-Path: <netdev+bounces-229143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898CBD87B1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525FD4068A3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9D2EA74C;
	Tue, 14 Oct 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVfHq2am"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E52E7BB5
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434853; cv=none; b=uVScmqNLyJ8OI9/+C5DP11jpKzz8UiaFbXC2XcQ2zHLXH5Klg2G9R5CX7JD1n6LWh7gKk3NLXQjc5NDvTETk9LedS4KNDhkQTD1loPkk9ioI7YYFmKgVBh5YWMHuuD8svGoS+40kuZiW/QeR7tkCa4CX6yneyQx362JAudTrYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434853; c=relaxed/simple;
	bh=KrqI6BN/pG8sniH9prZ9lemJ+Px5buZPfBBQDsr3OFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1qDH75kzGhV6NVlgXcD1IIY4eyYLzgSgUCWFaPgsYO9QNwQahkVNya7fULirXD2fXH4CNuMQ8ltmKQC+BhlHKMn/cmw+B1Q1jJ1uZ0nkDNKzP5rqqnFtQr+D4lJJK5qp+iVYC/kjq1ewV2N4wuN63cUO7aDneCIZgO0jMsIv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVfHq2am; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7f04816589bso657761785a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760434851; x=1761039651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0K5zqPBUa6pAT3aN4BIC0pePwm6+irtg+vq3VpmDXw=;
        b=dVfHq2amJepyAq4CshvY5G7xsf2Q8BOC2E5iXeeyY0OxaLQUUCmS1plA25rr3z/lVD
         Kzfmd6RQSRUYZv2Gg7l23JqmA0EPHD7tcFBke9B+WdUYPA9v9H0bPfkQU3GyZVT+GQir
         3017SPrU75cNyl+FCe94CYY3Pt0/LbRKOh/u8qFcOk1MkHcT/ADpldNwg/JvJ6VZ+XXG
         7JCLtoPmeEtEg1Q5FHEn73RnGB7E1HmGd+QuVz2sC8KcXCXwbnx9jy/4ssEGXuiwBQ/E
         ET51pjfnWxFN8Rp4S0uUoINu1iNQ5Ht7eYKhUIuVkzZG+Ic+QhSSrhUPWjr0yi8TBWvR
         rI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434851; x=1761039651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0K5zqPBUa6pAT3aN4BIC0pePwm6+irtg+vq3VpmDXw=;
        b=kj355t7IfcA2khm35k+l6cK1QfwGtWPw6um/NIN96MSarySC74JhUX/PqsDcTg+9OY
         FGJoJndDgjNloFL72z1NoVkEp77gCluWVYEQvtzjrkjmxby2CxTPB+f4G8dsctWau2QK
         kfPVVfcHryTOGDcLEZwrWpGr0+p5q/tvTL1GkC+mL9vSfpldsyivvOsUApNlkN0YIyVt
         Cxor6jmz0UMFDD0pP2vMy5O1aPsi03IjaAgUt7Bfl7AAEGRYJlsomi3q8rxvMN/tnAXG
         hl6+irZSprSuobIC6tOxRw8RpT0Tgl+apN9H2ro0wgrJNcCPrDmWUwq7+NWUCKfYAoI6
         4k0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrmxMZl68QPdWqxW3/WH99OhOdYq4SxXUHgFp2gEq5suun1WL5cWVl0pfSW9Mtddoc5aQdSHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPJ5oSqcBJjEZLG29gLrbSUq7kmw/ht1IPN7glnPr9Bw1njoQ
	vJ+YgQRXJ1zJ8dNs4ldt7mIxClTyk2tjBpo62BoDhDiLiCTWC+R3zQxcSKiXXK40z+DgdzuYi1r
	4dBUH+sB23FwUkTRCq8bDPgbOwq1YSWgZ9rXDPiSU
X-Gm-Gg: ASbGnctm4Zh7rqXIXDZkeOglGGdAAG/PBHD/lp/S+bfB3M3FOKZSY2tWGtb7a0cUNjm
	ih5hWt71pIQOCOYvAAAoDUUNQAzdXWN3aPzqNCHLOIV8QX+joLcLsLdHqiLFbk52Ivqw4VwZXlY
	oeqEzjKsW7kLRbcStdWN++s4V9knGZpjNX5XojrgOoPofRK2ddGHZOqjmrXTmwgueSIVbn16h1T
	ReZZp1pvDDbEePV2j2AD2u0nyn9U0zI71W/cNxwxWY=
X-Google-Smtp-Source: AGHT+IFIcauElXf63dvIvtCYlffelgR7gOw7ZLKhFdnOZazAbdT98c9ka9EyWFhYBvRfbrOg3Kp5ADj4VDBMwgtSBb0=
X-Received: by 2002:ac8:5d0e:0:b0:4d4:ac0e:1d8 with SMTP id
 d75a77b69052e-4e6ead7c5e5mr304086291cf.80.1760434850713; Tue, 14 Oct 2025
 02:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145926.833198-1-edumazet@google.com> <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
 <CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
 <CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com> <ffa599b8-2a9c-4c25-a65f-ed79cee4fa21@redhat.com>
In-Reply-To: <ffa599b8-2a9c-4c25-a65f-ed79cee4fa21@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 02:40:39 -0700
X-Gm-Features: AS18NWA1dj4wj0sa5FEYlFgWa2ljToVLzKl2oeJLeQwenPjJ3fwXt1fgIM8frTM
Message-ID: <CANn89iLyO66z_r0hfY62dFBuhA-WmYcW+YhuAkDHaShmhUMZwQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established flows
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:38=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>

> What about using a nf rule to drop all the 'tun0' egress packet, instead
> of a qdisc?
>
> In any case I think the pending patches should be ok.

Or add a best effort, so that TCP can have some clue, vast majority of
cases is that the batch is 1 skb :)

diff --git a/net/core/dev.c b/net/core/dev.c
index e281bae9b150..4b938f4d4759 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4226,6 +4226,13 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                        __qdisc_run(q);
                qdisc_run_end(q);
        } else {
+               if (!llist_next(ll_list)) {
+                       DEBUG_NET_WARN_ON_ONCE(skb !=3D llist_entry(ll_list=
,
+
struct sk_buff,
+                                                                 ll_node))=
;
+                       rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
+                       ll_list =3D NULL;
+               }
                llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
                        prefetch(next);
                        skb_mark_not_on_list(skb);

