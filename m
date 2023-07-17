Return-Path: <netdev+bounces-18317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A867566BD
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13162811AA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7B253B2;
	Mon, 17 Jul 2023 14:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26556BA27
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:47:22 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E24B2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:47:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-763a2e39b88so479511585a.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689605239; x=1692197239;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cRm0LMal11ZIFi5fpY87N5ZWlq8ce5XyX7RT10YDAg=;
        b=jZKAgle2nRHpuhUeoDxwqWgosL10PrJBKh4+Ivqfnsz34jSsgmTyM7nUNY74KSL9ge
         7U1AfkvBVdSKO0j/kLoHna5UsxJ6pntzsS6ciIn3Cq7UqeJ8Ki8M8ssPXhFknUJTBxm8
         5wgvd4JcBTYqhiURC1Nl0Sa9T52VyeHTIZMr0cPJTQa9w+gUjw+t1+59hS+oYNoCkf3+
         hV8Vh8kkKrtdvtT+fBgyDNrHnDESCNdn5KZnsqGgafqXaqDiLTsT9tWVLskg6QVAlahn
         pIzjtMgzrU11JWo7tfWsj+qBlLplamf4PvwUMMb+Hgxj8mL25JXzkAQ154hT/uCz5+BD
         2ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605239; x=1692197239;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cRm0LMal11ZIFi5fpY87N5ZWlq8ce5XyX7RT10YDAg=;
        b=QB8Fq6pkKTx01yPph9iZZUVdJz5592QJr/YZaKVYJJluC4aFrL7K+S83wfuC4Z33Kz
         bcHWyPr/fhe+LK9uIhByYj+8iboEEWG+YIfkz3g0GHWoLBaaOc80yV5bRZaCAnKZQHmS
         2jO9qtr8/GgKupw0k0CmvMECa0EvEdoogdc4rr/AYzCiqlzdwV2H5+TG//vll5GNiB+t
         e0ONI6j+szOVYnKZziDA0aXa24zizLvsDyYCpGlwThoO+hwuvudtxDQt9Ve1u32Dhfq1
         7waSW+kLE9tEn6rDA5U3Tq5IwKZxShv+jNcU4rKayasR8/Uji/XXLES5EnXnisXXzEUV
         vu6A==
X-Gm-Message-State: ABy/qLaSb0pJO+gQYmsp8YaiUDW6e6/aTpGWnifvgKt9SxgclCANmMrH
	JA+nLft6CV8NdsQt2DoJQuo=
X-Google-Smtp-Source: APBJJlHiVcQRGOVQ5weOJ291jF0gXlvDrc3ga2KaQGH4HcEHAGaGjwfJOviXQ8Uiwnuf3yM3ZZXUiw==
X-Received: by 2002:a05:620a:c45:b0:765:a6a5:e9fe with SMTP id u5-20020a05620a0c4500b00765a6a5e9femr16417952qki.44.1689605239351;
        Mon, 17 Jul 2023 07:47:19 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a120e00b00767b24f68edsm6184178qkj.62.2023.07.17.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:47:19 -0700 (PDT)
Date: Mon, 17 Jul 2023 10:47:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <64b55476ccacc_1e40ef294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <c835b29be1c86d765e9691b1f9772577fa3f560c.camel@redhat.com>
References: <8834aadd89c1ebcbad32f591ea4d29c9f2684497.1689587539.git.pabeni@redhat.com>
 <64b545c1316d2_1e11c1294e3@willemb.c.googlers.com.notmuch>
 <c835b29be1c86d765e9691b1f9772577fa3f560c.camel@redhat.com>
Subject: Re: [PATCH net-next] udp: introduce and use indirect call wrapper for
 data ready()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni wrote:
> On Mon, 2023-07-17 at 09:44 -0400, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> > > In most cases UDP sockets use the default data ready callback.
> > > This patch Introduces and uses a specific indirect call wrapper for
> > > such callback to avoid an indirect call in fastpath.
> > > 
> > > The above gives small but measurable performance gain under UDP flood.
> > 
> > Interesting. I recently wrote a patch to add indirect call wrappers
> > around getfrag (ip_generic_getfrag), expecting that to improve  UDP
> > senders. Since it's an indirect call on each send call. Not sent,
> > because I did not see measurable gains, at least with a udp_rr bench.
> > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > Note that this helper could be used for TCP, too. I did not send such
> > > patch right away because in my tests the perf delta there is below the
> > > noise level even in RR scenarios and the patch would be a little more
> > > invasive - there are more sk_data_ready() invocation places.
> > > ---
> > >  include/net/sock.h | 4 ++++
> > >  net/ipv4/udp.c     | 2 +-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 2eb916d1ff64..1b26dbecdcca 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -2947,6 +2947,10 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
> > >  }
> > >  
> > >  void sock_def_readable(struct sock *sk);
> > > +static inline void sk_data_ready(struct sock *sk)
> > > +{
> > > +	INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
> > > +}
> > > 
> > 
> > Why introduce a static inline in the header for this?
> > 
> > To reuse it in other protocols later?
> 
> I originally thought about re-using it even for TCP, but showed no gain
> there. I think/hope there could be other users, and I found the code
> nicer this way ;)

Until there are other users I disagree. And maybe even then, as this
is a single line function. It's more readable to see the actual code.

That said, no other concerns from me, if no one else objects.

