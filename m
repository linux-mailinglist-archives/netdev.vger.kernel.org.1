Return-Path: <netdev+bounces-45493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453677DD8AB
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 23:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5954B20D3D
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7AE2744E;
	Tue, 31 Oct 2023 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XsiCjnwC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5262F
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 22:58:12 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB2109
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:58:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c5249d55so8956646e87.3
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698793088; x=1699397888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cFlFdFyuZUTwVztV7JYMt/a8X940EneiCRrMOYKDV4E=;
        b=XsiCjnwCF1KvcLp+iTsVBdm4shw3Sl4ZdEgCyyQQRt5W3HtXu3mwTqP1Ohw+h3QLkz
         kuRUyf3LX1pxXZoGXk0MzFHPY5NYvo2tlQit3Heoyh4WJ4nYW6Gk3r6aDXjkZC+n6rw5
         LCSFRddTi5wBmjZS5ExEQ58+oTlDbnhO90K9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793088; x=1699397888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFlFdFyuZUTwVztV7JYMt/a8X940EneiCRrMOYKDV4E=;
        b=uKl3wM+dJA6+M9134O0780N8uykCu3Mf2pdwF8ludpBpv51fJTR+V+A2JCVlF/dgav
         MOZ4o6eonD7zIGvsUuHkeyy7eHUuHX0D/s9d8E/7YDoALImVyjpaThxLxbG909otn3y/
         gE20v/Oej4e+QYRuu97SLRJQfsvdX8F3AOhtMKZ9spgHHgoEiW9DlXn7+K8zgAjYKnca
         VK14XhrD4biiSbCOFkFi9IidhvKOEuAeEhLgTAK8TPQ6GHgqu+gU83zAdjoYs0x6JU6E
         llwMokqceRQXim8PMtaEtGrXJEebNjSaiZ7XIEhouMN9eYmIwanqjPQ5cEymsmyKx9/o
         Klhg==
X-Gm-Message-State: AOJu0YzdDKcvaMhlrsHs3JQGdmsabjDmprYNc9Z3PwhHSr2Wy4ZT4F+Z
	Dq1Tsk0waPK9dWXMCldP1FJ2q+GrwMDLNXISrLqptS7C
X-Google-Smtp-Source: AGHT+IGCxz+VRnsmzMsrHqnp+ls/H/zhck4Vas9nWRqqFgfbiFZA9w40jSJv/P4/LaNXYwXvjDWj7A==
X-Received: by 2002:ac2:47fb:0:b0:507:b8e1:76f0 with SMTP id b27-20020ac247fb000000b00507b8e176f0mr9302000lfp.22.1698793088577;
        Tue, 31 Oct 2023 15:58:08 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a16-20020a50c310000000b0054386466f56sm211388edb.60.2023.10.31.15.58.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 15:58:08 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9d274222b5dso519567766b.3
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:58:07 -0700 (PDT)
X-Received: by 2002:a17:907:74d:b0:9a9:e4ba:2da7 with SMTP id
 xc13-20020a170907074d00b009a9e4ba2da7mr483778ejb.49.1698793087553; Tue, 31
 Oct 2023 15:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028011741.2400327-1-kuba@kernel.org> <20231031210948.2651866-1-kuba@kernel.org>
In-Reply-To: <20231031210948.2651866-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Oct 2023 12:57:50 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
Message-ID: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
Subject: Re: [GIT PULL v2] Networking for 6.7
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Oct 2023 at 11:09, Jakub Kicinski <kuba@kernel.org> wrote:
>
> We ended up with some patches pushed on top of the previous tag over
> the weekend. So I threw in one well-validated PR from IPsec and
> the crypto build fix. Crypto people say the removed code was questionable
> in the first place.

Well, I had actually already merged the original pull request, and
then started a full allmodconfig build.

And because I'm off gallivanting and traveling, that takes 2h on this
poor little laptop, so I had left to do more fun things than watch
paint dry.

I pushed out my original merge. I'll pull the updates later.

Thanks,

              Linus

