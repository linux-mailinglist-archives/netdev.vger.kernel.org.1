Return-Path: <netdev+bounces-38966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993A7BD4BF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867A41C2084A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27D13FE4;
	Mon,  9 Oct 2023 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6sWnabb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A31C8ED
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:54:08 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA1F9F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 00:54:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11987a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696838045; x=1697442845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h352FGx59vcioNapcninHN6AK5Dc534x0lC4Q9q6E4Q=;
        b=J6sWnabbfhIfnvC9Y0di8LroKCpamvLD1hZiq2r7M7wczIaaoXJpCF8GLQFtp23FhF
         LqT02YiTzd7amFELoJS+bgMdWGSigHwfITw24gVzw9hmPlsGQ2IHvXGA2X3su+pq9lOy
         U8PUn1ifJYG8JfwgZ296jnPERQ7MOB4J6BPyYx/kp4Hwz7UgnQKv/6lLB1XCZAG1yD4v
         6vPK5MH5Kh0MuY/HgCS8fPbm7WELF1jtF9E3953fwWlaJnOiF9t/jsMPdLlmOjXC3Uul
         ye7V0SnXbmTzsYJJR2SL80+1vxJfE8LkwU7HujahiMRBPEshUbRBgq9Go3boNXz+lyy7
         SyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696838045; x=1697442845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h352FGx59vcioNapcninHN6AK5Dc534x0lC4Q9q6E4Q=;
        b=JNZ8HY8OeCWzUv/qnGIP7kwPmPK+haRmn9ZgKRb1Fj0kwEkDdmzZ+BMEpAwVuZS7zg
         xotIoQyzCvH2OyPC4IrDV6SilHV99ddlj/37ry+kZ09w9BC+LYpDeJ1QZC2XeSXyAKia
         3VDb9FNtQbKTRLagKFhi7vSsMtuzLLfb5xVY89FmaE4EK4lqWMPZVu6UKXhdC3Sy6ILO
         Th5XQsOS7RH77l9N+wZjI29OO61pk7dJJ9b2hB1Mi7fsV1OuvWjnBkJN29qciq1hM41J
         IyQK5LieHOMDJPsMYu2jhSg8qOWCnScClKyJEuHIB8A4ovhWObxCYJQtE/paZeLL591o
         4Egg==
X-Gm-Message-State: AOJu0YyDza38BidZIcJ3d6oa9NWltdp32l+3zIp1g31DUpxd/1NODft+
	dL5Z4r1R+bVYM1NILNL4xSTL7oYt3tLlafNteLwHHg==
X-Google-Smtp-Source: AGHT+IHsQHtiO+HFnDwGdTsCR/yEkTk+9iKWYFkj3SIWhzqIW+ImmjZj3Dee+Bbo+8oUayPw878DHRaxoahjxKWxo2k=
X-Received: by 2002:a05:6402:d4b:b0:53a:ff83:6123 with SMTP id
 ec11-20020a0564020d4b00b0053aff836123mr195876edb.3.1696838044799; Mon, 09 Oct
 2023 00:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev> <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev> <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev> <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
 <4a747fda-2bb9-4231-66d6-31306184eec2@linux.dev> <814b5598-5284-9558-8f56-12a6f7a67187@linux.dev>
In-Reply-To: <814b5598-5284-9558-8f56-12a6f7a67187@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Oct 2023 09:53:51 +0200
Message-ID: <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To: Yajun Deng <yajun.deng@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, dennis@kernel.org, tj@kernel.org, 
	cl@linux.com, mark.rutland@arm.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:07=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> wr=
ote:

> 'this_cpu_read + this_cpu_write' and 'pr_info + this_cpu_inc' will make
> the trace work well.
>
> They all have 'pop' instructions in them. This may be the key to making
> the trace work well.
>
> Hi all,
>
> I need your help on percpu and ftrace.
>

I do not think you made sure netdev_core_stats_inc() was never inlined.

Adding more code in it is simply changing how the compiler decides to
inline or not.

