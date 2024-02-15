Return-Path: <netdev+bounces-72141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E2856B47
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8605E1F23928
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130241369A4;
	Thu, 15 Feb 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oCluk6Mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E413848E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018783; cv=none; b=W670obygEYkYwBHQmPmRzgoXdzjSnAInSII7GW9FyY/whfbbbq48ynlPhgSdPAAI4kC2GjX8dW5QStmcYKBYWS0XIN6A4KAlAzq9r8zlLwB4DcQmX6fvHBqxQsEF9fvYjBX7vF1Cj6uK7Fwue8pXGmA23CO3HNt2btdqKNrv4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018783; c=relaxed/simple;
	bh=Ow2KNKuunpi3CFMpu4ctB3YxV++SCuTQIz8FvzYqWsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qydwJdyU5GWhCvNfUsVl29LKCL1ayBFQ4Zca0JXC9mnrg2Gyd8jWe4jmqw3oGhqAyKWr/vy+srwptGaxWhgRpbaV7dYC42vEEsQxQadZ854KEHZviwi79nFW+vw8watfNImqYTarh8pHCvL+bekuW5h8PsTPwgBU/TCMz5osE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=oCluk6Mu; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1940226276.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708018779; x=1708623579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDtOxyQIUrvHRZYbLeRYhzP9Am/nBdCIsn1qRJuLxtI=;
        b=oCluk6MuB1we9gNYwPOGpxeUsfl6PAWTP3M8fzoNoYYZ/A88EcpLAnESS8VpIfZmAf
         9m1tdlqCaI4brfNoR8QK4z5TzeRmcGtK38hghuU1nIMNTCw3yZFPf4Z4P7adB0l0h3xn
         b9BzJPnbQHW8jKmgXT1et/217j+ngKK5Rt+f6dvrQWAJqrCglkymhp12MUrku3VZAGg1
         U4DBvXTBm6F80NWS20w1mJ3wpdtVUszQaw4Goqli/WTFdFJak5xQtlYNkTB6M/Z2dFuG
         TH+qJXQUsOgqoIcAjPODENkHm7JRrG7Iy8XhpzxiPJoxi0s2tNQbNN0QeB365NaqEag3
         BUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018779; x=1708623579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDtOxyQIUrvHRZYbLeRYhzP9Am/nBdCIsn1qRJuLxtI=;
        b=Ew29IuzF2L9LMP+pHEgSW1qet5+pqS9I6kDPof7r2bePTQiVYY2QmNBXH9BbTKZGvM
         PQInNF4r8tfa7HxkVSXHGCdjFc1db24QAO21pqg0Ds/I/m6F1owhr0Mi+c3FxxVNAkDr
         zKrf8m12vt/E8UQIi6AcrTogC9SmqC25KFVN1d59KDvTMbySFmkFoLcwjsHp6cC8it0e
         +kgyrEsrmli1nvnsi0sT+63lsmwnVcuKDk+fqupjkva5NEnj3tfQDjbrlN1+dRBOVhL+
         MYYrELbfT7VyII8M4fcX2tqTTNxm9akEitav+V0mhhlvV5HyXNFeAZimvSxooFJHjyqA
         UzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQH+LR9GJ6eab1vVuWCF1f60AjW3hNfHEzdLe5T8ZSI8exEMBERqQ8sPp7tDeszj/3EXR/ygJynwaYjtkkoBtlC1PINXzV
X-Gm-Message-State: AOJu0YwZqAGmICylXfbqndGx8kKua26ID+IJOx97g+aloCJjoIHqCvxp
	sztOqMgjkGmcvGlRXx9JvZnbxphnpKvBkFotcFI27TSlskjVewYhpBmu/5ff1TNCEmreVzRHYXy
	dS6iUYELjVVFC668st13TI4yJHLNev9HWJpNk
X-Google-Smtp-Source: AGHT+IGwSaM8UUA2DlZQLmgb04t9x61k5G5l90Kp3W/JMy4waio3qsHOqLdGqzAHAHqwmRlx7ZC0mXhEzhGiFCRjBqg=
X-Received: by 2002:a25:c302:0:b0:dc2:201a:7f1a with SMTP id
 t2-20020a25c302000000b00dc2201a7f1amr4066205ybf.30.1708018779496; Thu, 15 Feb
 2024 09:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215160458.1727237-1-ast@fiberby.net> <20240215160458.1727237-2-ast@fiberby.net>
In-Reply-To: <20240215160458.1727237-2-ast@fiberby.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Feb 2024 12:39:28 -0500
Message-ID: <CAM0EoMndBjwC8Otx6th_dM_aV_r80NeLEke9C8PwzGt1q3vAMA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: sched: cls_api: add skip_sw counter
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llu@fiberby.dk, Vlad Buslov <vladbu@nvidia.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Cc Vlad and Marcelo..

On Thu, Feb 15, 2024 at 11:06=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnesen <=
ast@fiberby.net> wrote:
>
> Maintain a count of skip_sw filters.
>
> This counter is protected by the cb_lock, and is updated
> at the same time as offloadcnt.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  include/net/sch_generic.h | 1 +
>  net/sched/cls_api.c       | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 934fdb977551..46a63d1818a0 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -476,6 +476,7 @@ struct tcf_block {
>         struct flow_block flow_block;
>         struct list_head owner_list;
>         bool keep_dst;
> +       atomic_t skipswcnt; /* Number of skip_sw filters */
>         atomic_t offloadcnt; /* Number of oddloaded filters */

For your use case is skipswcnt ever going to be any different than offloadc=
nt?

cheers,
jamal

>         unsigned int nooffloaddevcnt; /* Number of devs unable to do offl=
oad */
>         unsigned int lockeddevcnt; /* Number of devs that require rtnl lo=
ck. */
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index ca5676b2668e..397c3d29659c 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3483,6 +3483,8 @@ static void tcf_block_offload_inc(struct tcf_block =
*block, u32 *flags)
>         if (*flags & TCA_CLS_FLAGS_IN_HW)
>                 return;
>         *flags |=3D TCA_CLS_FLAGS_IN_HW;
> +       if (tc_skip_sw(*flags))
> +               atomic_inc(&block->skipswcnt);
>         atomic_inc(&block->offloadcnt);
>  }
>
> @@ -3491,6 +3493,8 @@ static void tcf_block_offload_dec(struct tcf_block =
*block, u32 *flags)
>         if (!(*flags & TCA_CLS_FLAGS_IN_HW))
>                 return;
>         *flags &=3D ~TCA_CLS_FLAGS_IN_HW;
> +       if (tc_skip_sw(*flags))
> +               atomic_dec(&block->skipswcnt);
>         atomic_dec(&block->offloadcnt);
>  }
>
> --
> 2.43.0
>

