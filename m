Return-Path: <netdev+bounces-38442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF67BAF28
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 363251C208BB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1514369D;
	Thu,  5 Oct 2023 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5gB3pBe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1743689
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:13:20 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326961BCF
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:13:11 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65b02e42399so8163276d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547590; x=1697152390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2O2X72sw/T7xt9ZYaaZg62x6tjZu36SBUEiSSeviOQ=;
        b=H5gB3pBeJMg6Ej5sug8/52RRMg6NHi6N27nHUwQMTQvKHZLgdLpsv5YnhXPE8umvcn
         Z9xKLlh6K14rmHeT9MSbVq6g+Ccg8xHY/bdK4eVeUyKhmZ5Ho+FuiLOTz9qHy28budTU
         Nyoa4qk5l2lRsEt5OidagroRsXsJh+wzgOeSsWD15j8In9I4fAVGDkyxyKU/UrbW09Il
         O6ZNbd8aQrVcWtnTXP53qJ4CPvM10wFwMwXWV6KLMRvT6vKFZl9Z1ReileMmg668MHIV
         lK+iFnB3bdbjO/viT2aal8LS5SA89ZFF/bRFOvNCBN1LJLxpgYHVz6rUwuhLW6GviEPZ
         GtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547590; x=1697152390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2O2X72sw/T7xt9ZYaaZg62x6tjZu36SBUEiSSeviOQ=;
        b=kNH5arUOzkv6MBkJXrLf0vpKRq4RvThR7lYfWKrEhDb4BROR1jhJQ8yyi5kA43TgMC
         Sjw92plnsEqVrRkah8HjdKRs5OzL8IJgvgybiYYPjknKmXrXeu1UTQlKp8BNHFcnMsO/
         OBqeMyAvSVKtYG+KLDRvG+n7HZfOjkGVzeMxvFYxqt3PbcDhUjSyu3yt0pGet5lxjqwe
         fL41UzDyujM516GLqaqijd17fCjH4V39wGbRZYKNhh3S/9WNmbxoUOCkfe8r9NV5RDdP
         UX1lpvoux3H61FM5wZFIhxXshDxeKSrAH7b2ZZPU8yn3fRUlq2HsaN5dkajaDHR/DKDM
         5UUA==
X-Gm-Message-State: AOJu0YygyBuW41fclCR8c+SuKporRm/MgbUheA6ml6yGaBKpbhre+rb+
	hMMYl/Q1v08Nyk3xv2zIG+741LeNU5OY4F19n1FNXA==
X-Google-Smtp-Source: AGHT+IG5c0/pTKX96AVCxurr+fBXRzMwArsZvBBKtDR/g63IMgCzmXqnBgT2HDZ+O+ChaD+FDoqOkc/v3DsFrZzmd88=
X-Received: by 2002:a05:6214:808:b0:655:d870:7306 with SMTP id
 df8-20020a056214080800b00655d8707306mr6553318qvb.25.1696547590132; Thu, 05
 Oct 2023 16:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003041701.1745953-1-maheshb@google.com> <ZRzqLeAR3PtCV83h@hoboy.vegasvil.org>
In-Reply-To: <ZRzqLeAR3PtCV83h@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Thu, 5 Oct 2023 16:12:44 -0700
Message-ID: <CAF2d9jggffd6HtehuL-78ZFPqcJhO+HAe1FX-ehXc5oBmZ72Dw@mail.gmail.com>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 9:29=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Mon, Oct 02, 2023 at 09:17:01PM -0700, Mahesh Bandewar wrote:
> > add support for TS sandwich of the user preferred timebase. The options
> > supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONI=
C),
> > and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
> >
> > Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().
>
> NAK
>
> Don't just ignore feedback and repost.

I replied to all your earlier comments, which one do you think I had ignore=
d?

