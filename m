Return-Path: <netdev+bounces-84795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEEA89858B
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6792C1C20B28
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4380C09;
	Thu,  4 Apr 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMHig4SZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE61757F8
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228322; cv=none; b=nL34BEq5KtJdUaRscP5uK8oUNbdJ9oxNC95UAVOP2DvGlxx0FiA8NmwVikqLwm3xjyPOV8MuCDVirTR7favdPUVqDk6FGWW1w77TTz98rHWvQPnlazgzzQv36pkmsaMuAQT2AMDP7zch2ISFE5YnsCDJDl4NGfSiOZ+QHwGjpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228322; c=relaxed/simple;
	bh=EdtvoBukPT9bElPlweOCe5Q9pfjpP2PTBDviIr1amC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+sYTDvlO/NL8JC4iO5UdMTBgXDA6e1VDmGxpLJBT3dQeucrUbq++I7qOsgRUitKeeLrI4/p7ns+/DRZFpT27AgLKREWFTiZrFKfEFuRN1W5SjWDQ3sKS0Be7zhtUp9MZOcmVRKGJaRxYSfrcK2j9wWFGbAsAZ2DFank4S9Taj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMHig4SZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so8667a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712228319; x=1712833119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGn5NVJs/3hfENazcAUnSsy/bAXTy8kRiGljS0ZwrmU=;
        b=SMHig4SZT6kQARydbwZvdptz1IvytwBSKJR9GlWjMAg80bEulrQquiDlQmTuzHK1H9
         2C3Gfb9kbJGxNqPfkGpuK6X9qv9cBPXY+Jhp21DxCMNKRsRPRPOmI1Bk50/keZfTlCev
         yN7tlEH+rpNSdOvxTeYHxgcG6AuxpuvM7Qape1UGfagqJJ29upkkyWf7Mcpo3kgH5LcK
         CcblxyhfGetZDHp460F6EPUj/zjihTbgQUojxTDXUsJ7O8ei3dfvdLal04v4nlQzQjN/
         PIb646QF5C9wAOS6juyXiRSRNGFyt2OU9czixjcfnesKyiszAVQq+IMN45amBMyHQVdq
         B50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228319; x=1712833119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGn5NVJs/3hfENazcAUnSsy/bAXTy8kRiGljS0ZwrmU=;
        b=BlXY/aZ1MbYxmOVc0Pt5fOhcLIdHuJYwJoOs2Ikyu4cmpuvCYaeCE9+4pYYUiqx/M1
         JSYNqG1wfZfqZHYiHxa563P0FiLYLfC/3bewZsukVe65TWN5I14yJ5DGXLJz0ypSJMeh
         KQGm6wPH+oel2cjFSnuxhLs1QVvgKQ2ONjTpHVYIbPDCBYFlcbxjBx0hEZtw0dVcJKsi
         YJJX+p0QF4GWEv8lnRECdak82wHB6Vyfs6LH+3ByyH/A+NsSh5Bih5/iVy9iLhhBgYty
         MolhymwjbqC4xOtOeO9A4mS46DaoSwICtN2YguIGGKv0sK1/weFT/Vu2de82v7jnGakT
         jODg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+zwqCC0hanyOdrIE/T5lcGwuuHKER6cfjLnPfEX7gXoxAE/u+1INLF0hKiWKoBmjk2qjfxIaAriaBHfxUKbvrXme+Pru
X-Gm-Message-State: AOJu0YwA3lusFHpopFssafFwkfWyT4hOuFzo8//SqCWJxZHchd7lkBlk
	tl1zTGxoW9wRsJnp+PgX6BsH4ZXGuDq1/LClMdLBn+wHWbvr6WoCWEEVpVZKfwHjeyVbuQ7Ne+g
	FxOzllbSSAmot3goC5G9jkK5auwfOokYGYUu8
X-Google-Smtp-Source: AGHT+IH3KWhUydszxYkWMlx9jigIPAm3rzvu4GWPbZl3HVbmRfcTD9TqSOCY1S+NR3NVqBh8K+sZARv3ppAwoEX1O/A=
X-Received: by 2002:a05:6402:26c4:b0:56e:22b4:fa72 with SMTP id
 x4-20020a05640226c400b0056e22b4fa72mr37841edd.3.1712228319178; Thu, 04 Apr
 2024 03:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402215405.432863-1-hli@netflix.com> <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
 <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com>
 <b3kspnkcbj2p3c5q6rbujih72n7vouafpreg5mjsrgvf4fpu52@545rpheaixni> <CANn89iJ3YrSg-Y+g65vowMtBzvNokT2N7ffk4=uw33k3SsePPA@mail.gmail.com>
In-Reply-To: <CANn89iJ3YrSg-Y+g65vowMtBzvNokT2N7ffk4=uw33k3SsePPA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Apr 2024 12:58:25 +0200
Message-ID: <CANn89iJgr3f23-t2O+cMcyQixNhcTGVVwp3m69J3G28zW4MPkg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with scaling_ratio
To: Hechao Li <hli@netflix.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:

>
> >
> > Later with skb->len/skb->truesize, we get 0.66. However, the window
> > can't grow to this ratio because window_clamp stays at the initial
> > value, which is the initial tcp_full_space(sk), which is roughly 0.25 *
> > rcvbuf.
>
> Sure. Please address Jakub feedback about tests.

I think a less risky patch would be the following one.

If you agree, send a V2 of the patch.

Also remove from the changelog all the C code, this has no real value there=
.
changelog should be not too small, not too big.
If you want to capture this test code, please cook a separate patch
for net-next to add it in tools/testing/selftests/net
(But I guess iperf3 could be used instead, iperf3 is already used in
tools/testing/selftests)

Thanks !

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3c159ba029ff74b109c56a7c7d2fc..2bcf30381d75f84acf3b0276a4b=
348edeb7f0781
100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1539,11 +1539,10 @@ static inline int tcp_space_from_win(const
struct sock *sk, int win)
        return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }

-/* Assume a conservative default of 1200 bytes of payload per 4K page.
+/* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
-#define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
-                                  SKB_TRUESIZE(4096))
+#define TCP_DEFAULT_SCALING_RATIO (1 << (TCP_RMEM_TO_WIN_SCALE - 1))

 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {

