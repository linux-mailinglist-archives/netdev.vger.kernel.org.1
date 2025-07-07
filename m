Return-Path: <netdev+bounces-204484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA57AFACEC
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761547A3940
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149D275844;
	Mon,  7 Jul 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaIoVQBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51D27F006
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872768; cv=none; b=sW02O+gXCVMOHReY6D5ohUGY8cebarXaaeKgGy0BxPw7Gadr+hbRJznrtr6deAV9F7JnTvKZjeRVDm2tx4wn7NLsizQQTzJ8H6uZ+MlrQ/NSeL5boVkB7Xk7ay10hCDoYx6Te1dMlkT0FzBUyiMUm+J7Q85bL/0nqiuVCtTIP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872768; c=relaxed/simple;
	bh=htJZpPOj4gZZRU0I+jiYOIF5YRNV0fn3GX0M2AlliDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWZO/Fqj5VEwXM6MI+pZYe2r84+WBsMZozfW8Npo9evi5No1uhRedO1adz8pdRnM6lNuFJz1skMMHRVtD3VcgG4ZkS1m7enAREN61Zl5v/tdMmpgGzlGMj1J5rw/Rn27X7GIJUy3oS5YpuB/AUMskaCQRURYBS+H3Skd+EFyFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaIoVQBT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a7f46f9bb6so36573731cf.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751872765; x=1752477565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTVfC4cPTOGFHouVuim000ml3X3p9Az99Bki20NcXwY=;
        b=oaIoVQBTwC1tHoM7er1y3GzkdMZXtjLOFvV5P9BLDyFA502cxxz8LC1SSynprtri+Y
         KpCdGIcxVmLc05OMITGAJfXmayHqPZFept6SxGYm+m0AsZzFDmkJAhdezuwkP4tFKDD0
         WTzAxzpyvByFpYOWbxEz//cHeOZegaWkag7xkGpSL/cSNbiLvERC9fxeLj3Jq8uMuIAw
         cVEtIQaJzBvoyb2qeBNVdR6tNgK2scOrKlgbKMR3+xkJ8XINWVl6tPnQRyDaHG5Yqm3s
         zRxAP6wHOlm4XxAq1RmSfOxjm45Fe8NiO1gafPpDdTK77wEVqJ5C7wn+lvksJMNPV9Ta
         uo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751872765; x=1752477565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTVfC4cPTOGFHouVuim000ml3X3p9Az99Bki20NcXwY=;
        b=DCYEp1Hlo0UHW6QQmmv79R07nYsjD+fxlK8HSWNCgUYKtLWuquaS78WRxwRsrH3AIw
         y64vdSRNuHh5fMAJWD9etaL9HohHEIzMprgsj3ewJ+x7vdN3KJlXhNUHg5R0s+iuO6V/
         wpW23fnV0BYfBLx78IcuxeBa/qg9fOiwZe7nafTbL+CJ2ngpIpENcWdNGLteppZWUKcG
         mIzESXpUYQnlqoXd0tklVk9Fy+Wi6S8UOWLKyM8Jz/gDsOCNJJ4yJFbiZ6idXbWZEMAc
         I3pZe8njDVDJlBxCyJj9E4UUnaJHXkoeANJYLIly8SPCYV9lOGXTfptHKXVB442A/vlG
         j9UA==
X-Forwarded-Encrypted: i=1; AJvYcCUCnKCwoVOzUxChi+QgTa/ufLG5lJrHMIwgOZOnstUcq8cenKsPcgZmGbdJ6wvgyw3Edk9t7LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfa7g/9PGKoO6U6Mf8pd1hOuI2H0E2u/kpQEC0tjaxHosnZ02r
	Kq+39R7+FwqHGA3v0szAe6ioEZ5QzRanVuRJk2AzYmCczCKrLeaXnX0kl5p+H/RYCj2XEuq1KXh
	WOivrxBC5g61yWXjcHUIjBDgOF0DybcwAymLNfTA4
X-Gm-Gg: ASbGncuZNDZPcbtjaiQ6J8Dg0+tEQBsHUJ/I7/NCYXminsGTYZFiqAnLt9kD6OjSOq3
	SUG7HFzXQwZ/d+OvwL8Imga1pze3v+7lvgXEbrWt7ULsuP3xX5RTRdfWXGgfu14/dh92029kyco
	zvxz7wR0WTrUH58w3CxThw3I1Z4eFsyIeNSd6MHB2Fxw==
X-Google-Smtp-Source: AGHT+IEYyJhquDhXJu2A8CjIMcrkTyNJiyOZCUfQrqQPO5fEMO//qsgPpSXFGCGxLZ6mkwnM1V3ab9TFgsOoAydVU/I=
X-Received: by 2002:ac8:5fcf:0:b0:4a4:3d6e:57d4 with SMTP id
 d75a77b69052e-4a99883ca50mr157286881cf.46.1751872765053; Mon, 07 Jul 2025
 00:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a24a603-b49f-4692-a116-f25605301af6@redhat.com> <20250707061707.74848-1-yangfeng59949@163.com>
In-Reply-To: <20250707061707.74848-1-yangfeng59949@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Jul 2025 00:19:13 -0700
X-Gm-Features: Ac12FXz9Oflp4WxYHT8N81vIRj_r3KU6iZACjxfFM-KEdW2Z-wtBpQlqG96pyAg
Message-ID: <CANn89iLPYTArYRBKQmXF7TkcUxQCK53SJuAwmZY0GCxdFL7iNQ@mail.gmail.com>
Subject: Re: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet transmission
To: Feng Yang <yangfeng59949@163.com>
Cc: pabeni@redhat.com, aleksander.lobakin@intel.com, almasrymina@google.com, 
	asml.silence@gmail.com, davem@davemloft.net, david.laight.linux@gmail.com, 
	ebiggers@google.com, horms@kernel.org, kerneljasonxing@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	stfomichev@gmail.com, willemb@google.com, yangfeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 11:17=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:

>
> So do I need to resend the v2 version again (https://lore.kernel.org/all/=
20250627094406.100919-1-yangfeng59949@163.com/),
> or is this version also inapplicable in some cases?

Or a V3 perhaps, limiting MSG_MORE hint to TCP sockets where it is
definitely safe.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d6420b74ea9c6a9c53a7c16634cce82a1cd1bbd3..dc440252a68e5e7bb0588ab230f=
bc5b7a656e220
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3235,6 +3235,7 @@ typedef int (*sendmsg_func)(struct sock *sk,
struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offse=
t,
                           int len, sendmsg_func sendmsg, int flags)
 {
+       int more_hint =3D sk_is_tcp(sk) ? MSG_MORE : 0;
        unsigned int orig_len =3D len;
        struct sk_buff *head =3D skb;
        unsigned short fragidx;
@@ -3252,7 +3253,8 @@ static int __skb_send_sock(struct sock *sk,
struct sk_buff *skb, int offset,
                kv.iov_len =3D slen;
                memset(&msg, 0, sizeof(msg));
                msg.msg_flags =3D MSG_DONTWAIT | flags;
-
+               if (slen < len)
+                       msg.msg_flags |=3D more_hint;
                iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
                ret =3D INDIRECT_CALL_2(sendmsg, sendmsg_locked,
                                      sendmsg_unlocked, sk, &msg);
@@ -3292,6 +3294,8 @@ static int __skb_send_sock(struct sock *sk,
struct sk_buff *skb, int offset,
                                             flags,
                        };

+                       if (slen < len)
+                               msg.msg_flags |=3D more_hint;
                        bvec_set_page(&bvec, skb_frag_page(frag), slen,
                                      skb_frag_off(frag) + offset);
                        iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,

