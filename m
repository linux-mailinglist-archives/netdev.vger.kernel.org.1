Return-Path: <netdev+bounces-95333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA48C1E98
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62141C20D91
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9C15B116;
	Fri, 10 May 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSR6UNy7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE7F9C9
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324517; cv=none; b=cKGHoJ5i8705bSv41FwoEJ/hSCRl1opMH6pxIbSEFyK5g0bzafDkUtJjYYQKXsAVvAMJJQjpxO1H4DmH67zxGFd2TuLSH+dGROtMP+iAQS+XQW1cn3Zjh9WPslARWy0SAcJW97i78tzk3QzumHfeTGphBRx+NDHNB/NtA2eXrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324517; c=relaxed/simple;
	bh=7oGXbFORwBCyzCIXmLVRq2rm6tpAyoLE/wEl7xVni/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7lDRr8tEBBkE0yGS1qmeGu5Whhc3v1BlydEgNQlS1kmasrtNRnDIkFMB4qhhz3K4yaTIYoG1U90YOiFg1jx77G3ATaxo+yhemxuqxskRXNEowRKY1+Q20DY1iLY4mys7MAdGrP+Z8JkWVqoPEJ+nVXkRDESDfwI/HMjC8KXNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSR6UNy7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so55435e9.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715324513; x=1715929313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fNjQtXaSKOYp8nX/E0knSnpY+xEYmx9idjbqHww5m8=;
        b=FSR6UNy7ZCeAoKw4kCtum0FHjMP04IWADohr7m7A5TLlSkuMvQAjAcvzR8UjzJfBNC
         3tH7uJQlHm9S8jDO6mu/RD1pDyNcw8i8+pjqVYJmkM6H3p4vvwvDTCRPDQ+Lla7srN1u
         jHJWTGQxz/SPK7mJqIYKLsMtyepy5LA5XDs57QyfEYwjukbNg/MrZ/kCBNl6Khp3UTE0
         UERCbamJedTMLe+klmnv4hli01rs0GgW6e1p91U/vJNfArxZWxwAC9MDidnzM/4fMSVY
         kT/vxWA/+Z3IkROawa9ZCYxHlLHIJAIGXOyToPnpCgWZYyrgZUeNT+5U0HLEElf9UYyi
         cxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715324513; x=1715929313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fNjQtXaSKOYp8nX/E0knSnpY+xEYmx9idjbqHww5m8=;
        b=mpW4rdqPXoixP8K2HEzbYzi68+XrdUY5fQbpmodow+1s6aY9MNrAPMb1hcdZi2in2H
         Qo77CTUHHgb0w/zmKrpRKLVMn6JR5b7TJ8Okh9y8OOoVoiiKS/wuE2eaKP8UzQS32wVC
         e5exEELZ3fFaETotVSAEiVfO/Oq+It+jNDpTzLp3zneQ1Owmt3VV51PkQGa0HLhsGh1z
         1zh/3Dpa7D56b46wN5TWof1sEu1fhp1SW67MLNvH0dmhLXcpLazfK/W9bwlZlQjzLr1V
         yh1HJWKE2rpDlf8fbsCPT8LQD4JOA61fGXhn7fp7RLEpyDl7uxIlxNnnTydAzazyhiJd
         l9MA==
X-Forwarded-Encrypted: i=1; AJvYcCU9LJbWA8SDWFv7DU5X3aJu+qtltHAoEf/0bt3IUEMjalkPwdDCSX8L/jAmWr4+sYQqmPeuJxNTGv4kI5EfQ8wixc6X16Rc
X-Gm-Message-State: AOJu0YycuJkT/zsMCntg7/Uxyw1/j+pCr3sBsuGHukJc/OS3KyeKnaF3
	kmwJP8OQTk0unVUiG2Seow7FlC8VWuYiTOJPBSVH8TG4FdrxEC03U7Lcy0n7x3e7JrYVBIAktHn
	7PoSLbKXqVwMig4EhSxLx9q8p83ac0eG2TNUb
X-Google-Smtp-Source: AGHT+IHXgoYwv8mIiaDIGVOr7ncUPb8+Jxgb25xnmzzrh7Nx+vSrbhU+T7T2JV86E1ZVTxXeU3M9WBbaaejAwoMk2Q4=
X-Received: by 2002:a05:600c:6b13:b0:41b:e416:1073 with SMTP id
 5b1f17b1804b1-41fedc6d1d4mr1312435e9.0.1715324512596; Fri, 10 May 2024
 00:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507162349.130277-1-richardbgobert@gmail.com>
 <20240507163021.130466-1-richardbgobert@gmail.com> <CANn89iJfVHA=n-vSpFwoP3Jb8Wxr1hgem1rLqmyPWPUwDpe-cg@mail.gmail.com>
 <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
In-Reply-To: <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 May 2024 09:01:37 +0200
Message-ID: <CANn89iJ7TPa350Git+r2dp6rvvJ-TUTYj5RiLi7i5TWsBJO1bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Richard Gobert <richardbgobert@gmail.com>
Cc: alexander.duyck@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:58=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>

>
> Interesting, I think that is indeed a bug, that exists also in the curren=
t
> implementation.
> NAPI_GRO_CB(p)->ip_fixedid (is_atomic before we renamed it in this commit=
)
> is cleared as being part of NAPI_GRO_CB(skb)->zeroed in dev_gro_receive.

And the code there seems wrong.

A compiler can absolutely reorder things, I have seen this many times.

I would play safe here, to make sure NAPI_GRO_CB(skb)->is_atomic =3D 1;
can not be lost.

diff --git a/net/core/gro.c b/net/core/gro.c
index c7901253a1a8fc1e9425add77014e15b363a1623..6e4203ea4d54b8955a504e42633=
f7667740b796e
100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -470,6 +470,7 @@ static enum gro_result dev_gro_receive(struct
napi_struct *napi, struct sk_buff
        BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
                                        sizeof(u32))); /* Avoid slow
unaligned acc */
        *(u32 *)&NAPI_GRO_CB(skb)->zeroed =3D 0;
+       barrier();
        NAPI_GRO_CB(skb)->flush =3D skb_has_frag_list(skb);
        NAPI_GRO_CB(skb)->is_atomic =3D 1;
        NAPI_GRO_CB(skb)->count =3D 1;

