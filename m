Return-Path: <netdev+bounces-127948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315FA9772C6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B586FB23B8B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61BD1C0DF0;
	Thu, 12 Sep 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AA9Nv9yn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635681BC09F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173365; cv=none; b=NHYZUNGbVjQkESQNeS6NYZm350oSAuYuZAhh8ya4IL2WJQllU5uvCi7Iye7YV8APs5cgo+VdyDGdt4CBsRyzf6UaMSbzRO6ten9sbfqyKYnqCBdvQkTxffOu0WNCKiqHRDJ1o8/FG3cI0bxnPN54vth84roOBWWKx1k60qsGOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173365; c=relaxed/simple;
	bh=mp8OxZnlAYMgYyZ2/Ez6fdbNZhvu4GTGA4YzVEpNEE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2kZ6p4m5dDIrF02RKUyNesu/HpJpOLTiJO8lCFkcjh/ygdGHykN+dl67WzQcoEXG+V6nZltqlHuBE6rCz6GV8Ul38lkkoq9y+rVpBZaMb2rxsy0fPAGBLaP/wHDIvEkZmSRx8UtitOE0JBYTRYhpcuJ1RnehF+uDHUc6U4/Sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AA9Nv9yn; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4581cec6079so77281cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173363; x=1726778163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVIQGbBQieZXLtyFAGgcC2kYeEYDQhPg779xFDlLN5U=;
        b=AA9Nv9ynPtVEtgZKotRHhqXoGupVdCzyjlRSLVi3onL4Bj/OBGWfPTWu0ClPO7Tyi3
         PFTo+dOYVCmuflGxDKjaTw/rMf6i59vJ/QiI+wpEPy7QP+I7JFMVYK3m07eQUWNpBeFH
         PK5YH5g1Hk7t38ev51MzBM4Dzp87mUlYZMoUKPx5qVlwVMvMMCXPm2d7Hp5YXSqu+w/t
         t8bpUyLrevQOGam7LTedH2eC6tMJn+s4xZVMD1Vol6L2ZBAshSPis/4jpfTVzaJ70xb9
         Utaa2Ska/u5QcRILa69by+C/hE2pRWv83yfJvQ8q27C4SIrIuckfWvTHKFBK3YMtgKNb
         NgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173363; x=1726778163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVIQGbBQieZXLtyFAGgcC2kYeEYDQhPg779xFDlLN5U=;
        b=IUCZIJo2MpU7mNKwPYvSyqzrOHip0LMw0xdmJaqkwmInpdNkS84dLYdqWkBBghW/Xn
         35kHc/dMldsCgkm+IpCCJ24XQhEAT1ZnBaFSQ0aC/2tMaEuEtxOn6A60XVWc6PxYdzb4
         UwU0ysrjemOfCFCI2F67kZi45SBCO0O/Ejsv0wGsj6Mfx2rsux/EqoOCQOI0qfOM3W9Y
         6qFEvVO5MTpZaBSpkdaNwYfAlIIyzW2uoWYEy1q40/e2ny4Z7BI2c1GDSgHejg6Yw6C0
         Es2hJFlMXkbygQ6BQKu3aAy4+KI1aO3+JolQUy4Hd6GzCwPCO3qoLYwjv/uMs3NQVHb+
         fYWw==
X-Gm-Message-State: AOJu0YxC9Fgp1Pvx1WXKABixRUSlq1qCIRrMKQvCMdoK/s683kRGBLdr
	G+7zTtU7DCRMfbzWSdYAXxttQ63KnIwbhWF8tLStYjxMR3M1kF2WkTZILdtvdDgpD2N9M8re8SC
	OiUwsbeob3hNW8LiwotDe3jaZ2Jez3gytw2NY
X-Google-Smtp-Source: AGHT+IEbYUxcCI9Km45IW89PT/aB7akhCPNpOTwiQNmxwcIRYtzToqKXyferUXwjULFfa0pHYZIPNFOHV5OJ/omaMU4=
X-Received: by 2002:a05:622a:1312:b0:456:7740:c874 with SMTP id
 d75a77b69052e-458643fe57dmr4038061cf.1.1726173362878; Thu, 12 Sep 2024
 13:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-6-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-6-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 13:35:50 -0700
Message-ID: <CAHS8izP7MENG+q3y00LbAhzkP9yuLkC6NV3Bs77aQ5nw6YK4AA@mail.gmail.com>
Subject: Re: [PATCH net-next 05/13] selftests: ncdevmem: Unify error handling
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> There is a bunch of places where error() calls look out of place.
> Use the same error(1, errno, ...) pattern everywhere.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index a20f40adfde8..c0da2b2e077f 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -332,32 +332,32 @@ int do_server(struct memory_buffer *mem)
>
>         ret =3D inet_pton(server_sin.sin_family, server_ip, &server_sin.s=
in_addr);
>         if (socket < 0)
> -               error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> +               error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
>
>         socket_fd =3D socket(server_sin.sin_family, SOCK_STREAM, 0);
>         if (socket < 0)
> -               error(errno, errno, "%s: [FAIL, create socket]\n", TEST_P=
REFIX);
> +               error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFI=
X);
>

To be honest this was a bit intentional. For example here, I want to
see what errno socket() failed with; it's a clue to why it failed.

I guess you're not actually removing that, right? You're making the
return code of ncdevmem 1, but it will still print the errno of the
subfailure? That sounds fine.

Isn't it a bit more standard for the sub errno to be the return of the
parent process. But not opposed. If you think this is better we can go
for it.


--
Thanks,
Mina

