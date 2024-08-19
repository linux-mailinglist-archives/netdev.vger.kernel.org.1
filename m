Return-Path: <netdev+bounces-119790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB1A956F5C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AC2B20AF5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3013698B;
	Mon, 19 Aug 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3SCFCunC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2801304BF
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083032; cv=none; b=e7tVs//GvVzQk8nhFzvnG4cS/xmO3699Fy+o7mj9bYTmD1dNe4355+5nsIAyvQ5bJv7NxMziMOCczhCUFgNJ0/54Xr2iHpzHuxIGPjxAqAVN7gAfHqYQt/hphF19CeLJNk2KPOZssA5ZXRMVxEq3UEN2c2vbRTTiBREN4gUq7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083032; c=relaxed/simple;
	bh=gXttE3NWiTwQYdiUmm4dcQr5TYitLs/b7stwz4ODJnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukBCaQh2C6TC9FPNdZL3GreEKycRNXU2Cz9aNODfB6Qxd5hM1+laJYBoSibuYQ4qjyc4L5r/w3tCBEiwRNjUiBgmMUAqa0Jlht4rQ6ie8N4Z62K3xMrlB3v0yqR50sZPuFCDuNDkIqtq5fti/rORsEHM4/TJCxyNgpShBvCZiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3SCFCunC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so570814966b.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724083029; x=1724687829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjIDrpvPOvkDOXXW+amZUW2uDj/TRJZmby9hTwd9it8=;
        b=3SCFCunCZ7fLP246LG6v30RebzFUtLLPD+mXzlFNM2gPmngZudnzyMsB0NURsOO2tg
         c9lpF4GdsRxSzksetcZDBIWixU095yoI3en/VUOjh7jJhDlrJ+5ew0/FyNfs3FkgBFFY
         t6mk398DDslo8/0vHvDJ2J1ep2ZvGbK8dOMyWHHw3cGrcOudxW96vWaBXGaSGvoW7Pqd
         UgiNPksqW19g1zirurCZgdpYWKhsGATSPv0s3CGYEcdcY0VEgF9mGQzZ3UROEyLzJVHG
         oJ6BPJMZf1nqy9IwSE+ULaAKzSciZvNa+gA+gPPzMf7ZtBWdMasuaZ3Cf50uf98Wc5iU
         96bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083029; x=1724687829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjIDrpvPOvkDOXXW+amZUW2uDj/TRJZmby9hTwd9it8=;
        b=LLS2rayVWgHjZ0LLB1J8YECWZgqa7fDFSf/qfBfrCDDEN+xIHMFRJclPECOV2EPPqk
         gHdPbE1vmJBTg68uzdiTDrvcHuHbTmLB55PC4g2PbcNr7xjkGlTBb9k8LU3N/89IAY28
         AKlemxCYFnR18/PxJd3p8pxXIXOFNVceoB6VuekNvXt+HCAdELZGuFTrJvE3DPlsqz2J
         GC5Oq9zlzs2EgxmIff6quh+Z4uEOGROTlcM73/yZGtz0ZZINA9Di5I6DI6KHG1KGybaT
         aMhn6gb7pFCWWKEQ4Ct2WFZdNet6vQq5GCb5s1j4c0gVp3TWeyJ06qibgppj4G7ecuQ6
         nzrA==
X-Forwarded-Encrypted: i=1; AJvYcCXExLQhLrYrj+aIVdszqHsy+XlWpLdONfC6LJMPd/RafzvQxjEqDup3YVrQXYiLU1gNG2h/HIFNcDVF25y8a3hPPyDAB3h/
X-Gm-Message-State: AOJu0YxNqiXJKQSS3EBjTlckxzKSRYrMoCy3b9ntyzbsvBjycVEf7KXZ
	EVWnr3xLwQ9IsVsruJ45by1fqgxBVocupU6mJ7WMc5QZ7Rawe44EqfxVWlMeAbUsQTs2eItr6kf
	0X0vP9WtJsBU02v+ptP4Iakzrw71EJr/2mv5XUK9YoufHGsqc8w==
X-Google-Smtp-Source: AGHT+IGc9b0+OEAeubTxIZXIGAlAJIBVDWrE1Rw62eEcts0ArsgVnYl9HYRK9Q0COGWUvozFV0Cnzv6Kgt5VYqs9q0Q=
X-Received: by 2002:a17:907:7214:b0:a77:e55a:9e87 with SMTP id
 a640c23a62f3a-a83aa09f954mr488006766b.48.1724083028174; Mon, 19 Aug 2024
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815220437.69511-1-kuniyu@amazon.com>
In-Reply-To: <20240815220437.69511-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 17:56:55 +0200
Message-ID: <CANn89iK60jxsJCzq29WPSZJnYNHHpPS09_ZmSi1JHmbkZ2GznA@mail.gmail.com>
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tom Herbert <tom@herbertland.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:04=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> syzkaller reported UAF in kcm_release(). [0]
>
> The scenario is
>
>   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
>
>   2. Thread A resumes building skb from kcm->seq_skb but is blocked
>      by sk_stream_wait_memory()
>
>   3. Thread B calls sendmsg() concurrently, finishes building kcm->seq_sk=
b
>      and puts the skb to the write queue
>
>   4. Thread A faces an error and finally frees skb that is already in the
>      write queue
>
>   5. kcm_release() does double-free the skb in the write queue
>
> When a thread is building a MSG_MORE skb, another thread must not touch i=
t.
>
> Let's add a per-sk mutex and serialise kcm_sendmsg().
>
>
> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db72d86aa5df17ce74c60
> Tested-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

I wonder if anyone is using KCM....

