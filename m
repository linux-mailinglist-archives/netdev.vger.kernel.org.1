Return-Path: <netdev+bounces-114339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE49423A9
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA68285AA8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 00:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086538C;
	Wed, 31 Jul 2024 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRhxS5Zh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CA79D0
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384172; cv=none; b=R0YEnOGp6aHLpMVFMCceRemBvnT6XKUMZuYuFkrCAfV5ZCsouGYWOysQ3e/xu8mXFF0TX6lpkQeWKiqYh1eiOYR8+PGyq+LBzdYiaS/t0VS5Xj9Kc0G2nQgDXFjVS5nbB4O0CZ2gl8vRqfFl9qUDQO+hZ+trMfFeuRCJ5HClVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384172; c=relaxed/simple;
	bh=FadJN0NfYji6QcIgQNlkJGshIlT/BnMB+4RxVpxNrdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTOmu4WWynKhJ0JBL997nzlvdKpPafVEcKcU/EqPc7s94a2SODGX0KqnQ5NwO1DoskuWgOYVr7h3XhEd+ocld+wafBq+8NeUBagOq0wtHDozDxJ4BkgleHPRiOEt6CYvjxLSciAljseEXkB4Tw4L9A1rayPNQkw7RvQQzupjSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRhxS5Zh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so7913081a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722384169; x=1722988969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NZwyeqCkkdmhVGNTIUs2mJr9XGBsZCwLnRB8GMJzKs=;
        b=IRhxS5ZhkMhlE+IHCc9NRHGVA+y30Z/IFbizYE5avk3zgaAIg2gBN00lM3LU8wZQWs
         B4DXBxYBWxZ86BrX33LggSrb279LDOHngTsHWD6mJIN709p0+KRQeeWybLF1AmALoFT8
         etMoG1wTR9B31rgh5pVt14keoPL1jrKxXJUBWyQungukwJuv6Wsj+iGFamxtuv7r6vTU
         NcS8s5OVMGyMlO42PDtjKEMaN1deIwBQKX5t9lC7W8fjLw/o0enav1QvTX3gNwn+uK1Y
         xqMrBxBaJe0I4k8yjncqUv0MA+yPDMntW+hju8t+F8XGcKLFJJJpLG5YZLsg1Eslm7K4
         wk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384169; x=1722988969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NZwyeqCkkdmhVGNTIUs2mJr9XGBsZCwLnRB8GMJzKs=;
        b=ZOa0CV9WdPNaJJMBTQg/Re13Nf2XgWB0UDyKQxIqC9lMGBkPfq6mcesookHgRmz3FO
         vyGIuPAHZlRSZSEETIS0vD0uBsz3tDf7sbdC/29lQJAfRgY6/1cKC8ZwPAnyuGxRsx6s
         tPPgFuhmVlzUaNvKk7ErO3L8Pt1J/BpP0unMmrbjTCR+pOTBBJiWLkafjmeHaeltcGVW
         uUPnrgb2f07XMJFFatS4fe17x1hjOEYrLeFprS5O5dIDl0v59rC3GI0dhCIEPicRbA+l
         utFpAHpzYdnNIadEyefZcGDDqL+O66AsCRtISOO+PiMQSFSj0LRqqVXLo9NpjcOQa/fp
         nkAw==
X-Forwarded-Encrypted: i=1; AJvYcCVbywx+qIgTeCHlPodptxz9U/T3F2HLv4lkhC+x8BzEDKZ4kDihKVn5DNegKxLpNczh8wMyH3iUXuu+5WW60uxB1V1zetwN
X-Gm-Message-State: AOJu0YyliMn52ZG0gd+WnAog+jpnP0QMzgJeV3ad06ZADUphnFi3dcJv
	CtI2/uAALUfyOARmIC7qRxP3v3voC+AmYkciqYCx/bthCfq3aeywlgr/UpCXf6bMRkxaBL1ZxJE
	9IVIz2G4d+CBRC9QAIfVur67aG2A=
X-Google-Smtp-Source: AGHT+IEIp6HPBCHmKa0HJa6tQPvwRS8+C3i5KEXg8c5qYYGD5YFGZ3o/RJTJj+F72ZpY3E3tB4XFgFr1EqN0EIkFBEg=
X-Received: by 2002:a50:d696:0:b0:5a2:2ecc:2f0 with SMTP id
 4fb4d7f45d1cf-5b02000bde0mr8460681a12.1.1722384168855; Tue, 30 Jul 2024
 17:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730133513.99986-5-kerneljasonxing@gmail.com> <20240730200633.93761-1-kuniyu@amazon.com>
In-Reply-To: <20240730200633.93761-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 31 Jul 2024 08:02:11 +0800
Message-ID: <CAL+tcoDuChRQePz3wXSoSQ-X7MXtAevpTmfaQWthjhqaeQPDJQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_STATE for active reset
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kuniyuki,

On Wed, Jul 31, 2024 at 4:06=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Tue, 30 Jul 2024 21:35:11 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introducing a new type TCP_STATE to handle some reset conditions
> > appearing in RFC 793 due to its socket state.
>
> Why not RFC 9293 ?
> Was there any discrepancy ?

Thanks for the review.

My intention is to keep consistency with the comment in
tcp_need_reset(). I have no strong preference here. Either way is fine
with me.

Thanks,
Jason

>
>
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/rstreason.h | 6 ++++++
> >  net/ipv4/tcp.c          | 4 ++--
> >  net/ipv4/tcp_timer.c    | 2 +-
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > index eef658da8952..fecaa57f1634 100644
> > --- a/include/net/rstreason.h
> > +++ b/include/net/rstreason.h
> > @@ -20,6 +20,7 @@
> >       FN(TCP_ABORT_ON_CLOSE)          \
> >       FN(TCP_ABORT_ON_LINGER)         \
> >       FN(TCP_ABORT_ON_MEMORY)         \
> > +     FN(TCP_STATE)                   \
> >       FN(MPTCP_RST_EUNSPEC)           \
> >       FN(MPTCP_RST_EMPTCP)            \
> >       FN(MPTCP_RST_ERESOURCE)         \
> > @@ -102,6 +103,11 @@ enum sk_rst_reason {
> >        * corresponding to LINUX_MIB_TCPABORTONMEMORY
> >        */
> >       SK_RST_REASON_TCP_ABORT_ON_MEMORY,
> > +     /**
> > +      * @SK_RST_REASON_TCP_STATE: abort on tcp state
> > +      * Please see RFC 793 for all possible reset conditions
> > +      */
> > +     SK_RST_REASON_TCP_STATE,
>
> Same here.

