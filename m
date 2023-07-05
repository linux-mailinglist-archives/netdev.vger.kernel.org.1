Return-Path: <netdev+bounces-15460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB89747B16
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 03:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614AD1C20A64
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516E87F5;
	Wed,  5 Jul 2023 01:37:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600763C
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 01:37:43 +0000 (UTC)
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05543DD;
	Tue,  4 Jul 2023 18:37:42 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-57023c9be80so70267997b3.3;
        Tue, 04 Jul 2023 18:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688521061; x=1691113061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN7XER2lC+dl7J1HNSn0W9Zx2ZttZkRZmr3pnnvSqfI=;
        b=Q2pATHARnmH4QQoCN+s56LVC33Ixll/IeoBY6zcwlhAsEYH+WJdc2Jt2LY77mj6JCi
         xmyvIc+iNZIkvV3yyzLvBeIQYliYtFvb9LdSbzMSCaz+4m7NKx8gdXt8As9XeYhA+TZd
         YVyNCgYP/REiJaDyzIxiKL2zPNi6aBfiRvEkKGYcJh9An5PgruiJlSU6ER/8lRUr4gIH
         NJOqSJlvIENnnyZemNTUnVhse/p2EjTY4I2Ymn1ufEHsNIafJiHusmVVKZT5dRlK8xJl
         I88mQnmjS/HEqVT5RxzYcYac1H8UJpMxZicPsTX9r9uKjeLL8KNtxBFXtJhqu21olGdg
         fPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688521061; x=1691113061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SN7XER2lC+dl7J1HNSn0W9Zx2ZttZkRZmr3pnnvSqfI=;
        b=EkAebENKHucf8ub8VBuFfP/vR/P2IruIfYN1/zokkspgVR577/yvVN5wpUxbnfQ/5W
         YmHuCyq1WU3YNh9FhKAQbRhUYBNZ6ARojKWUAUqXIOGQlrTmDN1SxLe7ra8esmLTRIhc
         GH9f0fP6Go49AxwsprRPDe66Ia8kjmJNX/JK+RpQ1v+YAwwdeLa+VYNz575E5/WMSesr
         bY/2i5oNhlo0jQG7ZoqrMGLSl03QY8ohzYwz0FCfDZyDngVCh/ImJK8OxhbhaOfUf8wM
         po9GJMmYNchael+mP39G4F9IhCI2vDtTIc/yPixco92fnP8yu0uIOnQzs57IRPlTUIpc
         UHYA==
X-Gm-Message-State: ABy/qLY1Qx8vP9ThjOVZol7D4DwMvLQ59wyHYMg/Xjb9APUIeYrDzlMy
	yeUGWjw7ri/rKqRtJZ5rcsJvG4frBYrWKz+fiEg=
X-Google-Smtp-Source: APBJJlEh1na1tMXo6hWZ6i1C4Yj9Ls1hmmGxMJS07LugTvWlxQ9LHtWIklgmMVcORQwpmMwRLgW4TsUpFcrDZ1iGc+A=
X-Received: by 2002:a81:a544:0:b0:56d:2f0c:a516 with SMTP id
 v4-20020a81a544000000b0056d2f0ca516mr12767188ywg.11.1688521061096; Tue, 04
 Jul 2023 18:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704085236.9791-1-imagedong@tencent.com> <8ad620b632d723bc2f61ec1efb81d16c465d58bb.camel@redhat.com>
In-Reply-To: <8ad620b632d723bc2f61ec1efb81d16c465d58bb.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 5 Jul 2023 09:37:29 +0800
Message-ID: <CADxym3Y8G-eTuv2Hq=o3o95i=eKmh4jMnAphaWfSq5t=eaqtUA@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
To: Paolo Abeni <pabeni@redhat.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 9:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Tue, 2023-07-04 at 16:52 +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> > to clear the unnecessary noise of "kfree_skb" event.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
>
> ## Form letter - net-next-closed
>
> The merge window for v6.5 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after July 10th.
>

Sorry, I forgot that the net-next is closed. I'll resend it
after July 10th.

Thanks!
Menglong Dong

> RFC patches sent for review only are obviously welcome at any time.
>
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle
> --
> pw-bot: defer
>

