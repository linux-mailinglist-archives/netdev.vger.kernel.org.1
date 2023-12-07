Return-Path: <netdev+bounces-54993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B4809207
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05940B209D6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8081350246;
	Thu,  7 Dec 2023 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKe9FFta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD70A10F8
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 12:05:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso2059a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701979511; x=1702584311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB8LTH71ANCAcbZEklR3bZNBOviSvS9FwkI3zGUk7d8=;
        b=IKe9FFtae8AMaBJxwXSgkwqrowfYgB53uLG1tl34aGRSNVqoO65TbfvxsQ6OOo+4f/
         /XPZC9AngKZUbGLbvRE8zg0jm/nhmb2xlQEIKmpSH2TMtIGfLgRTkqql5kP6QxsxGt7U
         ZL2v9/5OvFATs6ZQx1n67AFQLaiEMPSBuRUMQJyyRAzJH6q3tIvgoi749FmlvbqzRJEb
         SSIEjZooz8Jfo7yizd6/C59J7ALw57Fvgo5f4MBmtqSZBf6ij0wmYhpIPyrGUkRiZb/M
         htPT9wgp4HhbqA0tN1ux67Ekt0RoyukvA96jLkIZ1b6DLzWb7KqDQvnZFdx23JBPkj6P
         vCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701979511; x=1702584311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB8LTH71ANCAcbZEklR3bZNBOviSvS9FwkI3zGUk7d8=;
        b=DhU6r4NXZBULVCIWUwVbYHqmXIgPUiYMg9JZ4ExyNnsn3axLp/Bm5+DVK5eyIrKd2X
         XgyMzTEeaxt4hEwpAVqjYs8Y94tXUYNdDdfxL/3T2ZV2qMy/yzZ0x5mv2G25nL9OOZJi
         9dmMaUTrNz39tZgD5P5NUYIHiw57jb0c67YW8EvOBaUFSQbO58UIOUxC7pq6o2w2Bo2A
         /Wy3Zof0lIkw43m1cNbbUI9AkOWX/QUZmVd72ZxUrQgZJMLTDUVuF/AJzQO/G7BB0tTH
         CX8x7zqZGuO4N0RlpxILTb7jfkmP0oYu2aMEdrEO6zQs7iw7bjhRdwtZ8OH6nIr24Xmw
         0y1g==
X-Gm-Message-State: AOJu0YwThBkqN9lIqe6BghaiCgJCXs1gXKqWobESmTD/PSHWs2bhQ9BX
	guwEXKjOdlVpgNWTtXGpQUZ6VjM8CKh9iQCHabExBxcle+bBEbzCOpE=
X-Google-Smtp-Source: AGHT+IGNWjIpTPulT7QZA9Y8gX0p30LAGC4o/5FZgFQpECNSbbdHLeCfZoj6IZvXYCyv2bol+0NS+/HV0owgizMoN9g=
X-Received: by 2002:a50:8d19:0:b0:54c:f4fd:3427 with SMTP id
 s25-20020a508d19000000b0054cf4fd3427mr58eds.7.1701979510771; Thu, 07 Dec 2023
 12:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207195051.556101-1-thinker.li@gmail.com>
In-Reply-To: <20231207195051.556101-1-thinker.li@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 21:04:57 +0100
Message-ID: <CANn89i+CTAYZft=LT+ZH8bg__9p63URnQH=s9=AL7MO4rbvPJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] ipv6: fix warning messages in fib6_info_release().
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 8:50=E2=80=AFPM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> The previous patch doesn't handle the case in ip6_route_info_create().
> Move calling to fib6_set_expires_locked() to the end of the function to
> avoid the false alarm of the previous patch.
>
> Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")

This looks quite wrong.

Let's separate things to have clean stable backports.

I will submit my single liner, you will submit a patch fixing your prior co=
mmit,
otherwise linux-6.6 and linux-6.7 will still have a bug.

