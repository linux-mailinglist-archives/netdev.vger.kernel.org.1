Return-Path: <netdev+bounces-136875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F29A3674
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27DA1F22EED
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4A185954;
	Fri, 18 Oct 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQZsvUnU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36616EB4C
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235189; cv=none; b=T8YYoxN/1Hz+EWTsDeKwJqI5Oh9r3OFiLi7N4YxWmmRXy78YZJJZfuGlSGRgSP4Wz/mUlYn+qlpvCiFeKr/8yfgMu/aNyHvoX7PIfo2g1u6fqQ1VnmtEndgUFYmI3bEy+75oa8oR9PyF8DXY27qflAuyD3DNXCe/41pW5h2nGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235189; c=relaxed/simple;
	bh=+LXYPc6hzDz1apqRx1+djjFCpV4f5yKQDtoRJZwRfQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGs+8C1P+Q01/qndUtvuz40HBhfNsmTlRzWWdMtXqEqE5x2SJb1ch/Q6iWwTy/ualsOy3/itr8zxtjt87whseXQh7FM8Z6/41XGzJYTBeWON2NyxJZiW5yiGz04pdmt3twfZBJicAKxu5TO5JGYkc98I9mmDq4h+Shh0qucJZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQZsvUnU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so21051281fa.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 00:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729235185; x=1729839985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sDh29tgBDN/eY+37mHiEnkCsD41OoxLIQqVYqiE06Y=;
        b=iQZsvUnUysgG3+Zmnrbp5TRbC0CZ3fHEb/lgnOGF/jnk25GYxwi2uCAnB17D1LldGf
         nixY9VIT0l4P7YQOKfsz/+NgUwv8F/YkhhQ57zM9TZMxJxdmua92yr8gB+jFmfb4Rk1I
         zjGNW0LwkXZsaXFdzgYY1lV8Yyn/mjqMg4ZtC01kMnVYaOMQwx5vLKACIYfJIk5jUwLm
         hdUnWmMtkGnql09wFJ1a48CKD9nZMz15NL3g8sRi08b6bqOhhwcxqAP0BkawJ4r0zEUf
         jeBDJ1Ryb3+/pVgLu19to+7/sppIfeDQ4SmR8HqJNh7I10oZ/bGGFfedihPfZZqn6oN6
         XFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729235185; x=1729839985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sDh29tgBDN/eY+37mHiEnkCsD41OoxLIQqVYqiE06Y=;
        b=Go26M9jHOWiHNORd9PiNB27BFsynTrdtmdZEQBGoVtbXexbs9wsg8jn56joA2DvjMw
         9vfNutuTX9R5BG7qwVV1nAJNZd5trzFsXn0lc+tr/8FmowUaMsH0JjwiFeyXrueCnm9Z
         HD0eoigWdIf2/3Grq4aa0HrFCHPIRK23+102UgS87d2z4J+3J7ROTpUwOwslxD22M5SO
         WbF9aSfcCJGj6pF+vboWhafMm0OGsVaJI9rhAIjTAgrTr535bu2Vonb/mtnqhCkmQSab
         VbxgzaBSPV6FY/qfmm8HIhSPLwJHHPTfGlAXY17tvOmnbgRwtkNgNdeCu9KofB49xli2
         L4nA==
X-Forwarded-Encrypted: i=1; AJvYcCWpRUmh9aFHWEVHcQsst5hxur2+2HtEvdlFhvb0ckCB8yiiwyaFxRHxsmhBVkDShLbSihSPdkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7F76GKsSXIlpGuLuBER1tSkYRoH4Xke0yz5Y8/bVf6RVKy/D
	Fowl2GKlXHEQqfRZ2MmULDxR/VSO23P+HOJcHu1CvudZElkuRVDE9rK8a1vOC1B8+cBpHWj9T+r
	u/FqBfFq+OdCqYBgeVo3lnd5oAnrJ3rS1aGMUusbDCPXYGOdXH7DV
X-Google-Smtp-Source: AGHT+IEID67jPLeUKh1bY4LIIgpCPYkyWpP4dlriYtHZlSy5ZWcIWo8EO6dx3Mc7MG9Ne0bnLTtz+chQnd/X6Cdop5k=
X-Received: by 2002:a05:651c:1543:b0:2fb:65c8:b4ca with SMTP id
 38308e7fff4ca-2fb83226659mr5746961fa.40.1729235185149; Fri, 18 Oct 2024
 00:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+nYHL-daCTUG=G0CaAMyabf9LkUYa6HnjhUCYLoJTm2FfMdsQ@mail.gmail.com>
In-Reply-To: <CA+nYHL-daCTUG=G0CaAMyabf9LkUYa6HnjhUCYLoJTm2FfMdsQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 09:06:12 +0200
Message-ID: <CANn89iJ4EwLU2H4CntDbufc3ZRS9-BZrO0vXGxYosx4ELq8PgA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __nf_hook_entries_try_shrink
To: Xia Chu <jiangmo9@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 9:00=E2=80=AFAM Xia Chu <jiangmo9@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our mod=
ified version of syzkaller.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> description: KASAN: use-after-free Read in __nf_hook_entries_try_shrink
> affected file: net/netfilter/core.c
> kernel version: 5.8.0-rc4
> kernel commit: 0aea6d5c5be33ce94c16f9ab2f64de1f481f424b
> git tree: upstream
> kernel config: attached
> crash reproducer: attached
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Crash log:
> BUG: KASAN: use-after-free in hooks_validate net/netfilter/core.c:177 [in=
line]
> BUG: KASAN: use-after-free in __nf_hook_entries_try_shrink+0x3c0/0x470 ne=
t/netfilter/core.c:260
> Read of size 4 at addr ffff888067fe4220 by task kworker/u4:2/126
>
> CPU: 1 PID: 126 Comm: kworker/u4:2 Tainted: G        W         5.8.0-rc4+=
 #1

This is an old version of linux, not supported.

What do you expect from us ?

