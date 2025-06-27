Return-Path: <netdev+bounces-201867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F65AEB4AC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DD63B8EC9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F4299AA4;
	Fri, 27 Jun 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/ktNeMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677E299931
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019818; cv=none; b=fg8bNg2POsKT5gJdm/9F1cGXNE9CgSLEkgDZ6gZAUbRSfBEOQ3c0gjh8EJsHC/nG63bI3i8ZmYuOYWI4oj6H94BV5nzmuB3+Vd1erKNSLrGM6Ldl0USX+PEUjvIJA2b2HLyNXSbuEFvtiMyFggmJF3piezvSFOkoH1e2SmFgjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019818; c=relaxed/simple;
	bh=V7FnJzBLi3EY72me3A2A+ErukVK7xe42c72R+6Jyi/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE6yyC6p8EzkzFxbiIKcPmHyrHZ+Uo/FaczTnB+5ydhoMqPwW17lj2h2vxkETYKifZMBXfA1rcnTfep1d47d7/6HXhrGCxq1YqaV1YmougYC1MHRnGPZ1Pj+NAYYdLwV1abHq2psRynwI4eSRHzgI3oo95lzZLA3+3XSO2kUtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/ktNeMf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43e277198so14028351cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751019816; x=1751624616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nKxFEYE/UeFFPamRqoXAyJPsV2H+5u5JXw+CSplOKw=;
        b=e/ktNeMfMu1V1LNTxfGWDxLHpT2pkc8Mr4+riNFRCd44XuCDlhF3r87scfMy+BADY8
         tI0RngoLspdHouMsEMG1N0c01WW712YfPMlnABRnaJvrlffjbAI5OXi0y74zdP/3NFxo
         R7RAeRLjG0du7PWwTvD5NB81LxVI8S/hlveUKpUbVzRwLNaWxzrIqEWegFq8oOU/j9mI
         +socf4glDNor0lSriFDcR5WkPHLqRrsVg7Ml609RSf8UZyVI0tsPL4gDyyRAgnO4ilSv
         f9otDvuo9bvALCk6z05BUwMQqOm58uz8y1GeIvGJlr7ErhQAW7mULBHVloTlgB7dys6+
         NFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019816; x=1751624616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nKxFEYE/UeFFPamRqoXAyJPsV2H+5u5JXw+CSplOKw=;
        b=fjaxvOgRN90NzyYWArZg5YVO+GNWrbePjegp+SG73Dv0dcLPAyoHTQj/OlictaA4+k
         HBgb7ZKQ0tw3ZqYquqkmKD+lserWEC+j4I+YOQzMq438CsYosmzsbt7thnMdbO/bYsmZ
         dTa8Peb6rdGEv6lSmnJQHE7Ofsp4qXtoExM08DPICWAW6QenbWOH0a4k1LUzvMivC25g
         RcrRHEl07Oj54WZCPMvgSK44CakRcr4mQU8/3ADIwJDzfAARYpnQOCTpKfnFgiZqewJ9
         ixa04+arpoqnJqd1KzOWpG8sHi7AaQrxL+y4MiHAA4saSPUxMqjitTOTBPR9bh6VTkPr
         XX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSTLZbXi3YR4nLZrlkgnV2l5pBbeQSNMgDRMnXSeU1yxLqr2Gwj8QtHRkBzxDO7do6wXaYcFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYZK7R+YolwzOQ+LffZUho+s8hknHQMYBRbHuSsAZyV8OYNju
	yxqfuR60xWx3JlL5iJicudrATGk5vl+uF0lFqcZAxxtVhUcqNaGubYJGLmUuwFquxpyG4p/o58q
	IkY/W1O9UYn9iO0KH+hgtI7xHYEvD9oUvjF4VAC6F
X-Gm-Gg: ASbGncvjOum2p4ru4Nbl1MoEmHrGzzMje/6EKR5RFRHccCP82MNkkvafBt5vIFeTjxE
	ca5nZQzWvbJMjyOP4i7jG5KVrxxNgpqUbuzomEY6qfxsydVbHXEn3N4uENM9RKwbkG3999OoDDO
	a9L6KZ8aFcxGylYmmZf7Qax2YTflFtH6s7duQ86oTJKMApJWPSSq4J
X-Google-Smtp-Source: AGHT+IFRBSu4OSWWwhUA10FKePzkXfzypfFlIilARxDfH6dzTpsWBTUQ/wDOJF5G8OVjrmkSdCmZJ9Dg3DqKmRy3yeY=
X-Received: by 2002:ac8:5796:0:b0:4a5:a96d:606d with SMTP id
 d75a77b69052e-4a7fcbe417dmr48902211cf.46.1751019815425; Fri, 27 Jun 2025
 03:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627094406.100919-1-yangfeng59949@163.com> <CANn89i+JziB6-WTqyK47=Otn8i6jShTz=kzTJbJdJgC0=Kfw6A@mail.gmail.com>
In-Reply-To: <CANn89i+JziB6-WTqyK47=Otn8i6jShTz=kzTJbJdJgC0=Kfw6A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Jun 2025 03:23:24 -0700
X-Gm-Features: Ac12FXzCqOJALJRgTaH8w7cAG6dXP3Xqdw3LY61OOOtlzGBfz-N8-LGxpyqFxy0
Message-ID: <CANn89iJs5qX_daLTob17t-ZLUQ5q+x9vvw=DP0CQVdLPGbtpKQ@mail.gmail.com>
Subject: Re: [PATCH v2] skbuff: Improve the sending efficiency of __skb_send_sock
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, almasrymina@google.com, kerneljasonxing@gmail.com, 
	ebiggers@google.com, asml.silence@gmail.com, aleksander.lobakin@intel.com, 
	stfomichev@gmail.com, yangfeng@kylinos.cn, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 3:19=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jun 27, 2025 at 2:44=E2=80=AFAM Feng Yang <yangfeng59949@163.com>=
 wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > By aggregating skb data into a bvec array for transmission, when using =
sockmap to forward large packets,
> > what previously required multiple transmissions now only needs a single=
 transmission, which significantly enhances performance.
> > For small packets, the performance remains comparable to the original l=
evel.
> >
> > When using sockmap for forwarding, the average latency for different pa=
cket sizes
> > after sending 10,000 packets is as follows:
> > size    old(us)         new(us)
> > 512     56              55
> > 1472    58              58
> > 1600    106             79
> > 3000    145             108
> > 5000    182             123
> >
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>
> Instead of changing everything, have you tried strategically adding
> MSG_MORE in this function ?

Untested patch:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d6420b74ea9c6a9c53a7c16634cce82a1cd1bbd3..b0f5e8898fdf450129948d82924=
0b570f3cbf9eb
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3252,6 +3252,8 @@ static int __skb_send_sock(struct sock *sk,
struct sk_buff *skb, int offset,
                kv.iov_len =3D slen;
                memset(&msg, 0, sizeof(msg));
                msg.msg_flags =3D MSG_DONTWAIT | flags;
+               if (slen < len)
+                       msg.msg_flags |=3D MSG_MORE;

                iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
                ret =3D INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3292,6 +3294,8 @@ static int __skb_send_sock(struct sock *sk,
struct sk_buff *skb, int offset,
                                             flags,
                        };

+                       if (slen < len)
+                               msg.msg_flags |=3D MSG_MORE;
                        bvec_set_page(&bvec, skb_frag_page(frag), slen,
                                      skb_frag_off(frag) + offset);
                        iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,

