Return-Path: <netdev+bounces-35939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02B7ABF60
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 3E6E51F236F9
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E270DDDAB;
	Sat, 23 Sep 2023 09:36:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB3D2F5
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 09:36:29 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEAE180
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 02:36:26 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4053c6f0d55so25221645e9.0
        for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 02:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695461785; x=1696066585;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wvRajMYgZD3FvWccqWRugbM5mUQdQPIjYnoPd05TMMQ=;
        b=XtUrg0YGiY9GnZq1SQKLOJSK1acpzZ76yH01a3y9A0iyhCztfkpt39m4HWa21fuKSe
         WHTc+UYdDYJTmsEc21UuGij/2snqm+Kj9+chDNuJ6B5r/v8sMAeoMTmx2kYShGRWTG/d
         IxaLz0C/R3gp78+ecUGBy205P1WF8SUzHCL5rWsr2LQCI5nJ+ETatrlM5rrTqSQ43PjT
         5M+FBok7YYO0FavFKf5exydnBDmZOT+RQV1Sz/Q5sdTxEb9NuPNVWrVpayEwuyb9Gi4V
         ngADZBugA/WFHZH8rLiLp9NmApJ95Cj3zB2HkHFWLdDDX31RRPdftafNfmboYOL9wzXC
         PZsw==
X-Gm-Message-State: AOJu0Yxe4/36Z85AhoZKo0+7/MkX8qvqZDcb8wo5EahfwxnG4h+4Blq5
	Lnkc8OvGUzimRTgHI/bjxB0UtoWTnTFMuv/9
X-Google-Smtp-Source: AGHT+IHhi8VABVLKKFMxgqoK9U/f7FYRH5MFm42XUdHs90XtwZWAKZgGeQBXJTnCOTW1Amp7AVjFNg==
X-Received: by 2002:a7b:c8d0:0:b0:402:fec4:fddc with SMTP id f16-20020a7bc8d0000000b00402fec4fddcmr1471510wml.17.1695461784928;
        Sat, 23 Sep 2023 02:36:24 -0700 (PDT)
Received: from [10.148.84.122] (business-89-135-192-225.business.broadband.hu. [89.135.192.225])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm4122635wml.47.2023.09.23.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 02:36:22 -0700 (PDT)
Message-ID: <3fd39981aba0e0aa8ced76398c2ea8ad85208f7d.camel@inf.elte.hu>
Subject: Re: question about BPF sk_skb_stream_verdict redirect and
 poll/epoll events
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Farbod Shahinfar <farbod.shahinfar@polimi.it>, john.fastabend@gmail.com,
  netdev@vger.kernel.org
Date: Sat, 23 Sep 2023 11:36:21 +0200
In-Reply-To: <be02a7af-5a00-fef7-2132-0199fad6ba7a@polimi.it>
References: <be02a7af-5a00-fef7-2132-0199fad6ba7a@polimi.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi!

On Fri, 2023-09-22 at 19:32 +0200, Farbod Shahinfar wrote:
> Hello,
>=20
> I am doing a simple experiment in which I send a message to a TCP
> server=20
> and the server echoes the message. I am attaching a BPF sk_skb=20
> stream_verdict program to the server socket to redirect the message
> back=20
> to the client (redirects the SKB on the same socket but to the TX=20
> queue). In my test, I noticed that the user-space server, which is
> using=20
> the poll system call, is woken up, and when it reads the socket,=20
> receives zero as the number of bytes read.

Do you poll for POLLIN events?

>=20
> I first want to ask if this is the intended behavior.
> In case this is the intended behavior, my second question is, what=20
> should I do to prevent the user program from waking up? I hope by not
> waking up the user program I could better use the available
> resources.

AFAIK sockets in sockmap are propagates every events to poll (fixme),
but with pollfd::events you can specify the ones makes sense to you
e.g.: POLLERR, POLLHUP, POLLRDHUP, etc.
>=20
> Sincerely,
> Farbod

Ferenc


